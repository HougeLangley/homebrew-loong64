class Nbimg < Formula
  desc "Smartphone boot splash screen converter for Android and winCE"
  homepage "https://github.com/poliva/nbimg"
  url "https://github.com/poliva/nbimg/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "f72846656bb8371564c245ab34550063bd5ca357fe8a22a34b82b93b7e277680"
  license "GPL-3.0-or-later"


  resource "homebrew-test-bmp", :test do
    url "https://gist.githubusercontent.com/staticfloat/8253400/raw/41aa4aca5f1aa0a82c85c126967677f830fe98ee/tiny.bmp"
    sha256 "08556be354e0766eb4a1fd216c26989ad652902040676379e1d0f0b14c12f2e2"
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9339b01235cfd37a739d5ea8624e843d53b7a331fa6bd1f02afdb8586da988c8"
  end

  def install
    inreplace "Makefile", "all: nbimg win32", "all: nbimg"
    system "make", "prefix=#{prefix}",
                   "bindir=#{bin}",
                   "docdir=#{doc}",
                   "mandir=#{man}",
                   "install"
  end

  test do
    resource("homebrew-test-bmp").stage testpath
    system bin/"nbimg", "-Ftiny.bmp"
    assert_path_exists testpath/"tiny.bmp.nb"
  end
end
