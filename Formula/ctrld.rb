class Ctrld < Formula
  desc "Highly configurable, multi-protocol DNS forwarding proxy"
  homepage "https://example.org/ctrld"
  version "1.5.8"
  url "http://127.0.0.1:8080/brew/bottles/ctrld--1.5.8.loongarch64.bottle.tar.gz"
  sha256 "6d6da9e369e443793931af6e7f4a7d96132471fc0849626d6506e5e78092adba"

  def install
    bin.install "ctrld"
  end

  test do
    system "#{bin}/ctrld"
  end
end
