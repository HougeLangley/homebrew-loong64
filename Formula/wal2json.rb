class Wal2json < Formula
  desc "Convert PostgreSQL changesets to JSON format"
  homepage "https://github.com/eulerto/wal2json"
  url "https://github.com/eulerto/wal2json/archive/refs/tags/wal2json_2_7.tar.gz"
  sha256 "e6c12d02dc32e4d610dce33ee52ea85a54e12a563e79c4844508b6c061ff07a1"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    regex(/(?:wal2json[._-])?v?(\d+(?:[._]\d+)+)/i)
    strategy :github_latest do |json, regex|
      json["tag_name"]&.scan(regex)&.map { |match| match[0].tr("_", ".") }
    end
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "859e6e7671af6e4e12f549b0712b8104119fb471f19329a50e4dbff2d508d70b"
  end

  depends_on "postgresql@17" => [:build, :test]
  depends_on "postgresql@18" => [:build, :test]

  def postgresqls
    deps.map(&:to_formula).sort_by(&:version).filter { |f| f.name.start_with?("postgresql@") }
  end

  def install
    odie "Too many postgresql dependencies!" if postgresqls.count > 2

    postgresqls.each do |postgresql|
      system "make", "install", "USE_PGXS=1",
                                "PG_CONFIG=#{postgresql.opt_bin}/pg_config",
                                "pkglibdir=#{lib/postgresql.name}"
      system "make", "clean"
    end
  end

  test do
    ENV["LC_ALL"] = "C"
    postgresqls.each do |postgresql|
      pg_ctl = postgresql.opt_bin/"pg_ctl"
      port = free_port

      datadir = testpath/postgresql.name
      system pg_ctl, "initdb", "-D", datadir
      (datadir/"postgresql.conf").write <<~CONF, mode: "a+"

        shared_preload_libraries = 'wal2json'
        port = #{port}
      CONF
      system pg_ctl, "start", "-D", datadir, "-l", testpath/"log-#{postgresql.name}"
      system pg_ctl, "stop", "-D", datadir
    end
  end
end
