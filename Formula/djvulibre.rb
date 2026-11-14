class Djvulibre < Formula
  desc "DjVu viewer"
  homepage "https://djvu.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/djvu/DjVuLibre/3.5.30/djvulibre-3.5.30.tar.gz"
  sha256 "ee5e457d4cfebe566f94b99e5e3d3cc7f5c79ddb741c2ac2ba2e456f00329644"
  license "GPL-2.0-or-later"
  compatibility_version 1

  livecheck do
    url :stable
    regex(%r{url=.*?/djvulibre[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "354bf73aad677324e90b669c2e88bffd8f1f919c96c52d991e795a5d3ef825e3"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "jpeg-turbo"
  depends_on "libtiff"

  deny_network_access!

  def install
    system "./autogen.sh"
    # Don't build X11 GUI apps, Spotlight Importer or Quick Look plugins
    system "./configure", "--prefix=#{prefix}", "--disable-desktopfiles"
    system "make"
    system "make", "install"
    (share/"doc/djvu").install Dir["doc/*"]
  end

  test do
    output = shell_output("#{bin}/djvused -e n #{share}/doc/djvu/lizard2002.djvu")
    assert_equal "2", output.strip
  end
end
