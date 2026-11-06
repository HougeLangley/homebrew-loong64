class Xclip < Formula
  desc "Access X11 clipboards from the command-line"
  homepage "https://github.com/astrand/xclip"
  url "https://github.com/astrand/xclip/archive/refs/tags/0.13.tar.gz"
  sha256 "ca5b8804e3c910a66423a882d79bf3c9450b875ac8528791fb60ec9de667f758"
  license "GPL-2.0-or-later"
  revision 1



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f8869b6c0734425e27340d796c0b756d81037b1ab3f4a481f0680de94b5a295f"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libx11"
  depends_on "libxmu"

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"xclip", "-version"
  end
end
