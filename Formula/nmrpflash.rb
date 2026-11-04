class Nmrpflash < Formula
  desc "Netgear Unbrick Utility"
  homepage "https://github.com/jclehner/nmrpflash"
  url "https://github.com/jclehner/nmrpflash/archive/refs/tags/v0.9.27.tar.gz"
  sha256 "a9de4296ec3db91e044f6ce5412342616920c6afda1df312bbeefc9013251f00"
  license "GPL-3.0-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f8726d3d65bf073898a8ca91e84f102c93be31d593713f6d30fe912c54f9d02a"
  end

  depends_on "pkgconf" => :build
  uses_from_macos "libpcap"

  on_linux do
    depends_on "libnl"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}", "VERSION=#{version}"
  end

  test do
    system bin/"nmrpflash", "-L"
  end
end
