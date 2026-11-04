class Hblock < Formula
  desc "Adblocker that creates a hosts file from multiple sources"
  homepage "https://hblock.molinero.dev/"
  url "https://github.com/hectorm/hblock/archive/refs/tags/v3.5.1.tar.gz"
  sha256 "af98a6753e5de1406b63cd1fabf4b3eae84816168c532dae40c83092acb69941"
  license "MIT"


  uses_from_macos "curl"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "dfd0fe031294a3f0e2f667d2d257768ddf24811dba97f9e616157cee56a513cf"
  end

  def install
    system "make", "install", "prefix=#{prefix}", "bindir=#{bin}", "mandir=#{man}"
  end

  test do
    output = shell_output("#{bin}/hblock -H none -F none -S none -A none -D none -qO-")
    assert_match "Blocked domains:", output
  end
end
