class Bootterm < Formula
  desc "Simple, reliable and powerful terminal to ease connection to serial ports"
  homepage "https://github.com/wtarreau/bootterm"
  url "https://github.com/wtarreau/bootterm/archive/refs/tags/v0.5.tar.gz"
  sha256 "95cc154236655082fb60e8cdae15823e4624e108b8aead59498ac8f2263295ad"
  license "MIT"
  head "https://github.com/wtarreau/bootterm.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1a3fb1235cd8b94ae4acd08f0b2348bb68d44daed3e0e66bd21e23c5f7fbe2c5"
  end

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    assert_match "port", shell_output("#{bin}/bt -l")
  end
end
