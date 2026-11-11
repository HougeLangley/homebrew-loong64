class Sqlite < Formula
  desc "SQL database engine (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/sqlite-3.53.3.tar.gz"
  sha256 "f84c26a4b5fe41e71b0e110e66ac95a6255e991e43a2875017a063bdad4f5809"
  version "3.53.3"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "31ab61f658d6f5b94a71a801957dce04c2e9180c7183337e6c52bf19f531e541"
  end

  def install
    bin.mkpath; lib.mkpath; include.mkpath; share.mkpath
    (lib/"libsqlite3.so.0").make_symlink "/usr/lib/libsqlite3.so.0" if File.exist?("/usr/lib/libsqlite3.so.0")
    (include/"sqlite3.h").make_symlink "/usr/include/sqlite3.h" if File.exist?("/usr/include/sqlite3.h")
    # Dependents' tests invoke `#{Formula["sqlite"].opt_bin}/sqlite3`; bridge
    # the system CLI too (graphqlite ENOENT evidence).
    (bin/"sqlite3").make_symlink "/usr/bin/sqlite3" if File.exist?("/usr/bin/sqlite3")
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
    assert_match version.to_s, shell_output("#{bin}/sqlite3 --version") if File.exist?("/usr/bin/sqlite3")
  end
end
