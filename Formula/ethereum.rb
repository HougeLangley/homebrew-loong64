class Ethereum < Formula
  desc "Official Go implementation of the Ethereum protocol"
  homepage "https://example.org/ethereum"
  version "1.17.10"
  url "http://127.0.0.1:8080/brew/bottles/ethereum--1.17.10.loongarch64.bottle.tar.gz"
  sha256 "12d3ed5e11b5fbdcf4e6e863b8440e72831024e343f0fcec41beebb334cfdecc"

  def install
    bin.install "ethereum"
  end

  test do
    system "#{bin}/ethereum"
  end
end
