class Stackrox < Formula
  desc "The StackRox Kubernetes Security Platform performs a risk analysis of the container enviro"
  homepage "https://example.org/stackrox"
  version "4.11.6"
  url "http://127.0.0.1:8080/brew/bottles/stackrox--4.11.6.loongarch64.bottle.tar.gz"
  sha256 "64e43706c5e4ae4f3e22b81d9ec8af8133588c4e1a551de18af22d6fec0b3402"

  def install
    bin.install "stackrox"
  end

  test do
    system "#{bin}/stackrox"
  end
end
