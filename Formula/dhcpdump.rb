class Dhcpdump < Formula
  desc "Monitor DHCP traffic for debugging purposes"
  homepage "https://github.com/dhcpdump-org/dhcpdump"
  url "https://github.com/dhcpdump-org/dhcpdump/releases/download/v2.00/dhcpdump-2.00.tar.xz"
  sha256 "41c79aa975662f33b1b7acaa0ab4c071b654cc78166c6475e82e3f0cfbe4b009"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end


  uses_from_macos "libpcap"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a136f795838a5e98247e5542f53bc523ee55eef833faa0300efb97e14cb8e26a"
  end

  def install
    # the interactive TUI (-t) needs yascreen, which isn't packaged
    system "make", "NO_TUI=1"
    bin.install "dhcpdump"
    man8.install "dhcpdump.8"
  end

  test do
    # live capture needs root; this capture holds no DHCP traffic, so nothing is printed
    assert_empty shell_output("#{bin}/dhcpdump -r #{test_fixtures("test.pcap")} 2>&1")
  end
end
