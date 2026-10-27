class Speedtest-go < Formula
  desc "CLI and Go API to Test Internet Speed using speedtest.net"
  homepage "https://example.org/speedtest-go"
  version "1.8.3"
  url "http://127.0.0.1:8080/brew/bottles/speedtest-go--1.8.3.loongarch64.bottle.tar.gz"
  sha256 "1952aaab354988615d07d660afa215d9d2907a8f2ec8d36fe2d3421eca7294b1"

  def install
    bin.install "speedtest-go"
  end

  test do
    system "#{bin}/speedtest-go"
  end
end
