class Cidr2range < Formula
  desc "Converts CIDRs to IP ranges"
  homepage "https://example.org/cidr2range"
  version "ipinfo-3.3.3"
  url "http://127.0.0.1:8080/brew/bottles/cidr2range--ipinfo-3.3.3.loongarch64.bottle.tar.gz"
  sha256 "b8810f7f7ce3cc5c6decc5e4d5cc8440f99d5463688d1f97670b6dac0a81adc7"

  def install
    bin.install "cidr2range"
  end

  test do
    system "#{bin}/cidr2range"
  end
end
