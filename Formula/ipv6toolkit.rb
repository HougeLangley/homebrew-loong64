class Ipv6toolkit < Formula
  desc "Security assessment and troubleshooting tool for IPv6"
  homepage "https://www.si6networks.com/research/tools/ipv6toolkit/"
  url "https://github.com/fgont/ipv6toolkit/archive/refs/tags/v2.2.tar.gz"
  sha256 "b6a1af3d3cf417a81dbb4cd99cf710d16a62338be4bfbbb14b8d1cb298849338"
  license "GPL-3.0-or-later"
  head "https://github.com/fgont/ipv6toolkit.git", branch: "master"

  livecheck do
    url :stable
    regex(/^(?:ipv6toolkit[._-])?v?(\d+(?:\.\d+)+)$/i)
  end


  uses_from_macos "libpcap"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "6ddaea3677548393c1a9f8726cb907ee2bbc2183860982497aafa0f4bf81825b"
  end

  def install
    system "make"
    system "make", "install", "DESTDIR=#{prefix}", "PREFIX=", "MANPREFIX=/share"
  end

  test do
    system bin/"addr6", "-a", "fc00::1"
  end
end
