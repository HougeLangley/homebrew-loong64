class Tcptraceroute < Formula
  desc "Traceroute implementation using TCP packets"
  homepage "https://github.com/mct/tcptraceroute"
  license "GPL-2.0-only"
  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "20169aba536a767124fc7c3694aeff12bdfb7f566c068d6ccccb2abc35f8a23e"
  end

  revision 2
  head "https://github.com/mct/tcptraceroute.git", branch: "master"

  stable do
    url "https://github.com/mct/tcptraceroute/archive/refs/tags/tcptraceroute-1.5beta7.tar.gz"
    sha256 "57fd2e444935bc5be8682c302994ba218a7c738c3a6cae00593a866cd85be8e7"

    # Call `pcap_lib_version()` rather than access `pcap_version` directly
    patch do
      url "https://github.com/mct/tcptraceroute/commit/3772409867b3c5591c50d69f0abacf780c3a555f.patch?full_index=1"
      sha256 "c08e013eb01375e5ebf891773648a0893ccba32932a667eed00a6cee2ccf182e"
      type :backport
      resolves "https://github.com/mct/tcptraceroute/issues/5"
    end
  end

  # This regex is open-ended because the newest version is a beta version and
  # we need to match these versions until there's a new stable release.
  livecheck do
    url :stable
    regex(/^(?:tcptraceroute[._-])?v?(\d+(?:\.\d+)+.*)/i)
  end



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libnet"

  uses_from_macos "libpcap"

  def install
    # Regenerate configure script for arm64/Apple Silicon support.
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--with-libnet=#{HOMEBREW_PREFIX}", "--mandir=#{man}", *std_configure_args
    system "make", "install"
  end

  def caveats
    <<~EOS
      tcptraceroute requires root privileges so you will need to run
      `sudo tcptraceroute`.
      You should be certain that you trust any software you grant root privileges.
    EOS
  end

  test do
    output = shell_output("#{bin}/tcptraceroute --help 2>&1", 1)
    assert_match "Usage: tcptraceroute", output
  end
end
