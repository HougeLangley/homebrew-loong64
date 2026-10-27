class Gateway-go < Formula
  desc "GateWay Client for OpenIoTHub"
  homepage "https://example.org/gateway-go"
  version "2.0.12"
  url "http://127.0.0.1:8080/brew/bottles/gateway-go--2.0.12.loongarch64.bottle.tar.gz"
  sha256 "346e1e34482baad63f0c7243c7d03d3e1b9a4992e0b0d97603c3748bd4a294ea"

  def install
    bin.install "gateway-go"
  end

  test do
    system "#{bin}/gateway-go"
  end
end
