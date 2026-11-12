class Arping < Formula
  desc "Utility to check whether MAC addresses are already taken on a LAN"
  homepage "https://github.com/ThomasHabets/arping"
  url "https://github.com/ThomasHabets/arping/archive/refs/tags/arping-2.29.tar.gz"
  sha256 "387955d6ba8eedcf242bb3784bebf8e40fad39703117e21e02cec12820990a5c"
  license "GPL-2.0-or-later"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a20b3ea86e342d0a8e4bdedd41d481c1da5e5eaa694e9780f88396fc7ea852d4"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libnet"

  uses_from_macos "libpcap"

  deny_network_access!

  def install
    system "./bootstrap.sh"
    system "./configure", *std_configure_args.reject { |s| s["--disable-debug"] }
    system "make", "install"
  end

  test do
    system sbin/"arping", "--help"
  end
end
