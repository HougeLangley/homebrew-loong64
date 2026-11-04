class Dnstop < Formula
  desc "Console tool to analyze DNS traffic"
  homepage "http://dns.measurement-factory.com/tools/dnstop/index.html"
  url "https://cdn.netbsd.org/pub/pkgsrc/distfiles/dnstop-20140915.tar.gz"
  mirror "http://dns.measurement-factory.com/tools/dnstop/src/dnstop-20140915.tar.gz"
  sha256 "b4b03d02005b16e98d923fa79957ea947e3aa6638bb267403102d12290d0c57a"
  license "BSD-3-Clause"

  livecheck do
    url "http://dns.measurement-factory.com/tools/dnstop/src/"
    regex(/href=.*?dnstop[._-]v?(\d+(?:\.\d+)*)\.t/i)
  end


  uses_from_macos "libpcap"
  uses_from_macos "ncurses"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a4fe7783ca2e4ea6d3dea9938b27647ab5d7676fef689b210efda5e69ad44ed7"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    bin.install "dnstop"
    man8.install "dnstop.8"
  end

  test do
    system bin/"dnstop", "-v"
  end
end
