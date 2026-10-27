class Dnsx < Formula
  desc "dnsx is a fast and multi-purpose DNS toolkit allow to run multiple DNS queries of your cho"
  homepage "https://example.org/dnsx"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/dnsx--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "6545146b1ab074785083895e2d29b07d056c1d5d1dac899f674b3fe723730ae5"

  def install
    bin.install "dnsx"
  end

  test do
    system "#{bin}/dnsx"
  end
end
