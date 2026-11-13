class Zlib < Formula
  desc "Lossless data-compression library (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/zlib-1.3.1.tar.gz"
  sha256 "f84c26a4b5fe41e71b0e110e66ac95a6255e991e43a2875017a063bdad4f5809"
  version "1.3.1"

  keg_only :provided_by_macos
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e43899616099e694fef4f32b0034b19588f9079c177daa8724b20707007732bd"
  end

  on_linux do
    keg_only "it conflicts with zlib-ng-compat"
  end

  def install
    bin.mkpath; lib.mkpath; include.mkpath; share.mkpath
    (lib/"libz.so.1").make_symlink "/usr/lib/libz.so.1" if File.exist?("/usr/lib/libz.so.1")
    (include/"zlib.h").make_symlink "/usr/include/zlib.h" if File.exist?("/usr/include/zlib.h")
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
  end
end
