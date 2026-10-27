class Cni-plugins < Formula
  desc "Container Network Interface plugins"
  homepage "https://example.org/cni-plugins"
  version "1.9.1"
  url "http://127.0.0.1:8080/brew/bottles/cni-plugins--1.9.1.loongarch64.bottle.tar.gz"
  sha256 "7f1323a5b4da8b33e866c1cd0da130e19e020dc438a95a1bf054ec5b8ea53334"

  def install
    bin.install "cni-plugins"
  end

  test do
    system "#{bin}/cni-plugins"
  end
end
