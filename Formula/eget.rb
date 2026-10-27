class Eget < Formula
  desc "Easily install prebuilt binaries from GitHub"
  homepage "https://example.org/eget"
  version "1.3.4"
  url "http://127.0.0.1:8080/brew/bottles/eget--1.3.4.loongarch64.bottle.tar.gz"
  sha256 "18f9c54088f89184f0ce31e43d3289d048e09e21972c2c1f4b886e5f81bd1cf9"

  def install
    bin.install "eget"
  end

  test do
    system "#{bin}/eget"
  end
end
