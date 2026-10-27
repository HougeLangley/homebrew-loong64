class Pretender < Formula
  desc "Your MitM sidekick for relaying attacks featuring DHCPv6 DNS takeover as well as mDNS, LLM"
  homepage "https://example.org/pretender"
  version "1.4.1"
  url "http://127.0.0.1:8080/brew/bottles/pretender--1.4.1.loongarch64.bottle.tar.gz"
  sha256 "ffa0c162a798648950a5753d4f3a87347cd1a1adae5047187eccffe06ceb1408"

  def install
    bin.install "pretender"
  end

  test do
    system "#{bin}/pretender"
  end
end
