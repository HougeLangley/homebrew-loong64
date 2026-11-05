class Sqlite < Formula
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "1bce4c5c0736c19762d3134e6bb94c02c37f18986c11d1cff5c6e0776b9348a4"
  end

  desc "SQL database engine (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/sqlite-3.53.3.tar.gz"
  sha256 "f84c26a4b5fe41e71b0e110e66ac95a6255e991e43a2875017a063bdad4f5809"
  version "3.53.3"

  def install
    bin.mkpath; lib.mkpath; include.mkpath; share.mkpath
    (lib/"libsqlite3.so.0").make_symlink "/usr/lib/libsqlite3.so.0" if File.exist?("/usr/lib/libsqlite3.so.0")
    (include/"sqlite3.h").make_symlink "/usr/include/sqlite3.h" if File.exist?("/usr/include/sqlite3.h")
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
  end
end
