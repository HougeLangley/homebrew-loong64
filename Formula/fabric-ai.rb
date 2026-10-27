class Fabric-ai < Formula
  desc "Open-source framework for augmenting humans using AI"
  homepage "https://example.org/fabric-ai"
  version "1.4.556"
  url "http://127.0.0.1:8080/brew/bottles/fabric-ai--1.4.556.loongarch64.bottle.tar.gz"
  sha256 "a6f70e4270d5ccc5d55874c98cc43a08f881a408c0f7151735c390cff01af8fb"

  def install
    bin.install "fabric-ai"
  end

  test do
    system "#{bin}/fabric-ai"
  end
end
