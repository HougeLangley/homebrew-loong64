class Pwnat < Formula
  desc "Proxy server that works behind a NAT"
  homepage "https://samy.pl/pwnat/"
  url "https://github.com/samyk/pwnat/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "c784ac0ef2249ae5b314a95ff5049f16c253c1f9b3720f3f88c50fc811140b44"
  license "GPL-3.0-or-later"
  head "https://github.com/samyk/pwnat.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e2496624743d143d30d62efd77d3ff57c705b752797c95b61dd6fa3c743c6056"
  end

  def install
    system "make", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}"
    bin.install "pwnat"
    man1.install "manpage.txt" => "pwnat.1"
  end

  test do
    assert_match "pwnat <-s | -c> <args>", shell_output("#{bin}/pwnat -h", 1)
  end
end
