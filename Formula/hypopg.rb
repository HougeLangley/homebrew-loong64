class Hypopg < Formula
  desc "Hypothetical Indexes for PostgreSQL"
  homepage "https://github.com/HypoPG/hypopg"
  url "https://github.com/HypoPG/hypopg/archive/refs/tags/1.4.4.tar.gz"
  sha256 "727ce0a14183291cb3f30a02b4a6f9a3d99d539bf761602bafb9e20688a6cb5c"
  license "PostgreSQL"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c2ea7e9bccefa510d6a5104620271df1f3bb244b7e06889e86595a4dc34c3e99"
  end

  depends_on "postgresql@17" => [:build, :test]
  depends_on "postgresql@18" => [:build, :test]

  def postgresqls
    deps.map(&:to_formula).sort_by(&:version).filter { |f| f.name.start_with?("postgresql@") }
  end

  def install
    odie "Too many postgresql dependencies!" if postgresqls.count > 2

    postgresqls.each do |postgresql|
      ENV["PG_CONFIG"] = postgresql.opt_bin/"pg_config"
      system "make"
      system "make", "install", "pkglibdir=#{lib/postgresql.name}",
                                "datadir=#{share/postgresql.name}",
                                "pkgincludedir=#{include/postgresql.name}"
      system "make", "clean"
    end
  end

  test do
    ENV["LC_ALL"] = "C"
    postgresqls.each do |postgresql|
      pg_ctl = postgresql.opt_bin/"pg_ctl"
      psql = postgresql.opt_bin/"psql"
      port = free_port

      datadir = testpath/postgresql.name
      system pg_ctl, "initdb", "-D", datadir
      (datadir/"postgresql.conf").write <<~EOS, mode: "a+"
        port = #{port}
        unix_socket_directories = '#{testpath}'
      EOS
      system pg_ctl, "start", "-D", datadir, "-l", testpath/"log-#{postgresql.name}"
      begin
        system psql, "-h", testpath, "-p", port.to_s, "-c", "CREATE EXTENSION hypopg;", "postgres"
      ensure
        system pg_ctl, "stop", "-D", datadir
      end
    end
  end
end
