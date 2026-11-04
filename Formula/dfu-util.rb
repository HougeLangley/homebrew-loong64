class DfuUtil < Formula
  desc "USB programmer"
  homepage "https://dfu-util.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/dfu-util/dfu-util-0.11.tar.gz"
  sha256 "b4b53ba21a82ef7e3d4c47df2952adf5fa494f499b6b0b57c58c5d04ae8ff19e"
  license "GPL-2.0-or-later"


  head do
    url "https://git.code.sf.net/p/dfu-util/dfu-util.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "13dc37cf84495964fed0d00753f146f6c640d6ea62255a4ce93250e0bad0b118"
  end

  depends_on "pkgconf" => :build
  depends_on "libusb"

  deny_network_access!

  def install
    system "./autogen.sh" if build.head?
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"dfu-util", "-V"
    system bin/"dfu-prefix", "-V"
    system bin/"dfu-suffix", "-V"
  end
end
