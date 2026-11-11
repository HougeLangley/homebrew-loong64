class Sqlite < Formula
  desc "SQL database engine (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/sqlite-3.53.3.tar.gz"
  sha256 "f84c26a4b5fe41e71b0e110e66ac95a6255e991e43a2875017a063bdad4f5809"
  version "3.53.3"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e99e7f66169cface5e262fe1ea61075ece0b847c4b03220ec9dac16ad69cc43c"
  end

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
