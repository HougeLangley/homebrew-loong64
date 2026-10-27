class Coredns < Formula
  desc "DNS server that chains plugins"
  homepage "https://example.org/coredns"
  version "1.15.0"
  url "http://127.0.0.1:8080/brew/bottles/coredns--1.15.0.loongarch64.bottle.tar.gz"
  sha256 "ca48ad3271a57d3b9fa6a7fd032d1154b51b302cd9d629e59a2b4500f6da8cd9"

  def install
    bin.install "coredns"
  end

  test do
    system "#{bin}/coredns"
  end
end
