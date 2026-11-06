class Mpfr < Formula
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4e4c23afa58bf74dfab0550fdaf66af5f18f28d0bccec310cd80ac60b7844e39"
  end

  desc "Multiple-precision floating-point library (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/mpfr-4.2.2.tar.gz"
  sha256 "f84c26a4b5fe41e71b0e110e66ac95a6255e991e43a2875017a063bdad4f5809"
  version "4.2.2"

  def install
    bin.mkpath; lib.mkpath; include.mkpath; share.mkpath
    (lib/"libmpfr.so.6").make_symlink "/usr/lib/libmpfr.so.6" if File.exist?("/usr/lib/libmpfr.so.6")
    (include/"mpfr.h").make_symlink "/usr/include/mpfr.h" if File.exist?("/usr/include/mpfr.h")
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
  end
end
