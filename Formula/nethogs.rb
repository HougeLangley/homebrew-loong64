class Nethogs < Formula
  desc "Net top tool grouping bandwidth per process"
  homepage "https://raboof.github.io/nethogs/"
  url "https://github.com/raboof/nethogs/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "5961bef2155c05695d2fe7e79aa11194981b5afd1cad9bf1f259c7f30d5487c3"
  license "GPL-2.0-or-later"


  uses_from_macos "libpcap"
  uses_from_macos "ncurses"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7682ed8de3c6db8018f3c914e59b92aee3f6f8af3cee88ac719bad4e2ada4029"
  end

  def install
    ENV.append "CXXFLAGS", "-std=c++14"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    # Using -V because other nethogs commands need to be run as root
    system sbin/"nethogs", "-V"
  end
end
