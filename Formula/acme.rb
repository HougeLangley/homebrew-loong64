class Acme < Formula
  desc "Crossassembler for multiple environments"
  homepage "https://sourceforge.net/projects/acme-crossass/"
  url "https://github.com/UffeJakobsen/acme/archive/d2683cc64dcb1afc643388100b14e575f8bfb1bd.tar.gz"
  version "0.97"
  sha256 "efda4ca8db9811e28e4604d25b5941888c949c175d1b47e40610c90a7b74a73d"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://sourceforge.net/p/acme-crossass/code-0/HEAD/tree/trunk/docs/Changes.txt?format=raw"
    regex(/New in release v?(\d+(?:\.\d+)+)/i)
    strategy :page_match
  end


  # Last release on 2020-07-10 with only binary distribution.
  # Most repositories (Arch, Debian, FreeBSD, nixpkgs, etc.) have moved
  # to following SVN revisions but not supported in Homebrew
  deprecate! date: "2026-10-17", because: "does not have a checksummed source"
  disable! date: "2027-04-17", because: "does not have a checksummed source"

  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "4bdb297912995fb59b61ea15cd81dd6394c5e9127fdc018ea88db0d41de5f08a"
  end

  def install
    system "make", "-C", "src", "install", "BINDIR=#{bin}"
    doc.install Dir["docs/*"]
  end

  test do
    path = testpath/"a.asm"
    path.write <<~ASM
      !to "a.out", cbm
      * = $c000
      jmp $fce2
    ASM

    system bin/"acme", path
    code = File.open(testpath/"a.out", "rb") { |f| f.read.unpack("C*") }
    assert_equal [0x00, 0xc0, 0x4c, 0xe2, 0xfc], code
  end
end
