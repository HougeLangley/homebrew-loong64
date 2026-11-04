class Masscan < Formula
  desc "TCP port scanner, scans entire Internet in under 5 minutes"
  homepage "https://github.com/robertdavidgraham/masscan/"
  url "https://github.com/robertdavidgraham/masscan/archive/refs/tags/1.3.2.tar.gz"
  sha256 "0363e82c07e6ceee68a2da48acd0b2807391ead9a396cf9c70b53a2a901e3d5f"
  license "AGPL-3.0-only"
  head "https://github.com/robertdavidgraham/masscan.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f31a955c22e2609c3976bd250873cb0956bfb1c5e64ad456083bff264b83a85a"
  end

  def install
    system "make"
    bin.install "bin/masscan"
  end

  test do
    assert_match "ports =", shell_output("#{bin}/masscan --echo")
  end
end
