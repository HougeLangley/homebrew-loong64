class Tiff2png < Formula
  desc "TIFF to PNG converter"
  homepage "http://www.libpng.org/pub/png/apps/tiff2png.html"
  url "https://github.com/rillian/tiff2png/archive/refs/tags/v0.92.tar.gz"
  sha256 "64e746560b775c3bd90f53f1b9e482f793d80ea6e7f5d90ce92645fd1cd27e4a"
  license "ISC"
  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "55393b62534a4a4278b19e0c9118a6708711b6cd6a50a9cf8879ce18df392052"
  end

  revision 3



  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    bin.mkpath
    system "make", "INSTALL=#{prefix}", "CC=#{ENV.cc}", "install"
  end

  test do
    system bin/"tiff2png", test_fixtures("test.tiff")
  end
end
