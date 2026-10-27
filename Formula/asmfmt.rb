class Asmfmt < Formula
  desc "Go Assembler Formatter"
  homepage "https://example.org/asmfmt"
  version "1.3.2"
  url "http://127.0.0.1:8080/brew/bottles/asmfmt--1.3.2.loongarch64.bottle.tar.gz"
  sha256 "0679b13804406d0ddf4b0be2fa5c31a47ff96e06e263da752f32b5f57b4e0b18"

  def install
    bin.install "asmfmt"
  end

  test do
    system "#{bin}/asmfmt"
  end
end
