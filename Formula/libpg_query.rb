class LibpgQuery < Formula
  desc "C library for accessing the PostgreSQL parser outside of the server environment"
  homepage "https://github.com/pganalyze/libpg_query"
  url "https://github.com/pganalyze/libpg_query/archive/refs/tags/18.1.0.tar.gz"
  sha256 "2d3486cf6a9d3955b53e66235db39d62b54216c820cd392ab66dc842c5b1316d"
  license all_of: ["BSD-3-Clause", "PostgreSQL"]
  compatibility_version 2


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "745a19ddb4facd89ea6957189817d4e9b242fe79749d88927ddf3a054c85c691"
  end

  def install
    # Turn off strlcpy(), it is working only if glibc 2.38+ on Linux.
    if OS.linux?
      inreplace "src/postgres/include/pg_config.h",
                "#define HAVE_DECL_STRLCPY 1",
                "#define HAVE_DECL_STRLCPY 0"
    end

    system "make"
    system "make", "install", "prefix=#{prefix}"
    include.install "postgres_deparse.h"
    pkgshare.install "examples"
  end

  test do
    cp pkgshare/"examples/simple.c", testpath
    system ENV.cc, "simple.c", "-o", "test", "-L#{lib}", "-lpg_query"
    assert_match "stmts", shell_output("./test")
  end
end
