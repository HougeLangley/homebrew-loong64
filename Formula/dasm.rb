class Dasm < Formula
  desc "Macro assembler with support for several 8-bit microprocessors"
  homepage "https://dasm-assembler.github.io/"
  url "https://github.com/dasm-assembler/dasm/archive/refs/tags/v2.20.17.tar.gz"
  sha256 "4755532fe8c990c8616b4cfbe22c3fe5820e40476343da01e088b617bd2d1144"
  license "GPL-2.0-or-later"
  version_scheme 1


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "362b6d8db42066459614e42b1645e4ef2d8e8ee4284733fd630dea950837faa4"
  end

  def install
    system "make"
    prefix.install "bin", "docs", "machines"
  end

  test do
    path = testpath/"a.asm"
    path.write <<~ASM
      ; Instructions must be preceded by whitespace
        processor 6502
        org $c000
        jmp $fce2
    ASM

    system bin/"dasm", path
    code = (testpath/"a.out").binread.unpack("C*")
    assert_equal [0x00, 0xc0, 0x4c, 0xe2, 0xfc], code
  end
end
