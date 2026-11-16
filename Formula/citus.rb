class Citus < Formula
  desc "PostgreSQL-based distributed RDBMS"
  homepage "https://www.citusdata.com"
  url "https://github.com/citusdata/citus/archive/refs/tags/v14.3.0.tar.gz"
  sha256 "1d024dddcf448e553994b07d8def22d6db30dc27388560c98e602721eb6a63f6"
  license "AGPL-3.0-only"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f4232505fd7a42a3c4a89580e3bd0567877596213ef3f2541316c8400e78436e"
  end

  head "https://github.com/citusdata/citus.git", branch: "main"

  # There can be a notable gap between when a version is tagged and a
  # corresponding release is created, so we check the "latest" release instead
  # of the Git tags.
  livecheck do
    url :stable
    strategy :github_latest
  end



  depends_on "postgresql@17" => [:build, :test]
  depends_on "postgresql@18" => [:build, :test]
  depends_on "libpq"
  depends_on "lz4"
  depends_on "openssl@4"
  depends_on "zstd"

  uses_from_macos "curl"

  def postgresqls
    deps.filter_map { |f| f.to_formula if f.name.start_with?("postgresql@") }
        .sort_by(&:version)
  end

  def install
    odie "Too many postgresql dependencies!" if postgresqls.count > 2

    # We force linkage to `libpq` to allow building for multiple `postgresql@X` formulae.
    # The major soversion is hardcoded to at least make sure compatibility version hasn't changed.
    # If it does change, then need to confirm if API/ABI change impacts running on older PostgreSQL.
    libpq_args = %W[
      libpq=#{formula_opt_lib("libpq")/shared_library("libpq", 5)}
      rpathdir=#{formula_opt_lib("libpq")}
    ]

    postgresqls.each do |postgresql|
      ENV["PG_CONFIG"] = postgresql.opt_bin/"pg_config"

      mkdir "build-pg#{postgresql.version.major}" do
        system "../configure", *std_configure_args
        system "make", *libpq_args
        # Override the hardcoded install paths set by the PGXS makefiles.
        system "make", "install", "bindir=#{bin}",
                                  "datadir=#{share/postgresql.name}",
                                  "pkglibdir=#{lib/postgresql.name}",
                                  "pkgincludedir=#{include/postgresql.name}"
      end
    end
  end

  test do
    ENV["LC_ALL"] = "C"

    postgresqls.each do |postgresql|
      ENV["PGDATA"] = testpath/postgresql.name
      pg_ctl = postgresql.opt_bin/"pg_ctl"
      psql = postgresql.opt_bin/"psql"
      port = free_port

      # Keep the server socket inside testpath, the only place the test sandbox allows unix sockets
      system pg_ctl, "initdb", "--options=-c port=#{port} -c shared_preload_libraries=citus " \
                               "-c unix_socket_directories=#{testpath}"
      system pg_ctl, "start", "-l", testpath/"log"
      begin
        system psql, "-h", testpath, "-p", port.to_s, "-c", "CREATE EXTENSION \"citus\";", "postgres"
      ensure
        system pg_ctl, "stop"
      end
    end
  end
end
