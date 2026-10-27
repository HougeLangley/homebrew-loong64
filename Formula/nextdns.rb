class Nextdns < Formula
  desc "CLI for NextDNS's DNS-over-HTTPS (DoH)"
  homepage "https://example.org/nextdns"
  version "1.47.3"
  url "http://127.0.0.1:8080/brew/bottles/nextdns--1.47.3.loongarch64.bottle.tar.gz"
  sha256 "51670efade91b1cbb689e614ce41fb472fe9bd482cab6ff2366c915b2e057143"

  def install
    bin.install "nextdns"
  end

  test do
    system "#{bin}/nextdns"
  end
end
