class Chisel < Formula
  desc "A fast TCP/UDP tunnel over HTTP"
  homepage "https://example.org/chisel"
  version "1.12.0"
  url "http://127.0.0.1:8080/brew/bottles/chisel--1.12.0.loongarch64.bottle.tar.gz"
  sha256 "47fe02248424500c429be4d67fb2876b9dad16e0d498dca81e1b11284aa7f96d"

  def install
    bin.install "chisel"
  end

  test do
    system "#{bin}/chisel"
  end
end
