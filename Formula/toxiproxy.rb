class Toxiproxy < Formula
  desc "TCP proxy to simulate network & system conditions for chaos & resiliency testing"
  homepage "https://example.org/toxiproxy"
  version "2.13.0"
  url "http://127.0.0.1:8080/brew/bottles/toxiproxy--2.13.0.loongarch64.bottle.tar.gz"
  sha256 "5a5c0befb5bd77a35f80953cae56efb438d31b81b31293726f34cb3882ddcc41"

  def install
    bin.install "toxiproxy"
  end

  test do
    system "#{bin}/toxiproxy"
  end
end
