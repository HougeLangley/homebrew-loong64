class Cloudflare-ddns < Formula
  desc "🌟 A small, feature-rich, and robust Cloudflare DDNS updater"
  homepage "https://example.org/cloudflare-ddns"
  version "1.18.0"
  url "http://127.0.0.1:8080/brew/bottles/cloudflare-ddns--1.18.0.loongarch64.bottle.tar.gz"
  sha256 "0f6c59084699dc9cf12edd29b316d8331363cf465637c4c1a12a9df227ceebe3"

  def install
    bin.install "cloudflare-ddns"
  end

  test do
    system "#{bin}/cloudflare-ddns"
  end
end
