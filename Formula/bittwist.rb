class Bittwist < Formula
  desc "Libcap-based Ethernet packet generator"
  homepage "https://bittwist.sourceforge.io"
  url "https://downloads.sourceforge.net/project/bittwist/macOS/Bit-Twist%204.7/bittwist-macos-4.7.tar.gz"
  sha256 "2ff00070d57221672af5198268088ffee8ed6b5ade33d6f26be5b3b4125b48f1"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0e9462842556243d349b167c62bb752add9bc5c32d15ce3afcb95e2e6647d330"
  end

  depends_on "libnl"
  uses_from_macos "libpcap"

  def install
    # The Linux Makefile links libpcap statically through LPCAP, not LIBS.
    # Keep netlink after libpcap and use the real libnl-3 library name.
    lpcap = "-Wl,-Bstatic -lpcap -Wl,-Bdynamic -lnl-genl-3 -lnl-3"
    system "make", "LPCAP=#{lpcap}"
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system bin/"bittwist", "-help"
    system bin/"bittwiste", "-help"
  end
end
