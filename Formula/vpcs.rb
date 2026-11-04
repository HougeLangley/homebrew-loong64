class Vpcs < Formula
  desc "Virtual PC simulator for testing IP routing"
  homepage "https://vpcs.sourceforge.net/"
  url "https://github.com/GNS3/vpcs/archive/refs/tags/v0.8.5.tar.gz"
  sha256 "1d5443366db189d50331d2b83a23bdb172568b3b77bb0890d9cc8307e58d0023"
  license "BSD-2-Clause"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "db6f61f2fec90b710cb9de77ae9300195a8c3cb39862365141400cb4bc898b2d"
  end

  def install
    os = OS.mac? ? "osx" : OS.kernel_name.downcase
    system "make", "-C", "src", "-f", "Makefile.#{os}"
    bin.install "src/vpcs"
  end

  test do
    system bin/"vpcs", "--version"
  end
end
