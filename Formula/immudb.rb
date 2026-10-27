class Immudb < Formula
  desc "Lightweight, high-speed immutable database"
  homepage "https://example.org/immudb"
  version "1.11.2"
  url "http://127.0.0.1:8080/brew/bottles/immudb--1.11.2.loongarch64.bottle.tar.gz"
  sha256 "ec5834e5192a8a66fe95a2671b7f381c0642276d3b7be04af0d10885d1819e4f"

  def install
    bin.install "immudb"
  end

  test do
    system "#{bin}/immudb"
  end
end
