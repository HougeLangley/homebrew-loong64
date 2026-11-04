class Ndpi < Formula
  desc "Deep Packet Inspection (DPI) library"
  homepage "https://www.ntop.org/products/deep-packet-inspection/ndpi/"
  url "https://github.com/ntop/nDPI/archive/refs/tags/6.0.tar.gz"
  sha256 "21fc40cab5505942c0b21d9bbaf73e9adf8162ddfe782e4cd072cab855a2eda9"
  license "LGPL-3.0-or-later"
  compatibility_version 1
  head "https://github.com/ntop/nDPI.git", branch: "dev"

  livecheck do
    url :stable
    regex(/^v?(\d+(:?\.\d+)+)$/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c91679fafc036ce3c33c172715e78cb7f0738e73c782d289440b73803ffb5f40"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "json-c"

  uses_from_macos "libpcap"

  deny_network_access!

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"ndpiReader", "-i", test_fixtures("test.pcap")
  end
end
