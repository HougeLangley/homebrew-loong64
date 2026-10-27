class Chisel-tunnel < Formula
  desc "Fast TCP/UDP tunnel over HTTP"
  homepage "https://example.org/chisel-tunnel"
  version "1.12.0"
  url "http://127.0.0.1:8080/brew/bottles/chisel-tunnel--1.12.0.loongarch64.bottle.tar.gz"
  sha256 "2eda0b338505e524f4e050520b489a1c71967d65aa29a8fd346ecee911050660"

  def install
    bin.install "chisel-tunnel"
  end

  test do
    system "#{bin}/chisel-tunnel"
  end
end
