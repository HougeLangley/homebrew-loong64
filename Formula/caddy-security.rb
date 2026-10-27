class Caddy-security < Formula
  desc "🔐 Authentication, Authorization, and Accounting (AAA) App and Plugin for Caddy v2. 💎 Imple"
  homepage "https://example.org/caddy-security"
  version "1.5.0"
  url "http://127.0.0.1:8080/brew/bottles/caddy-security--1.5.0.loongarch64.bottle.tar.gz"
  sha256 "344986f0cec82842372bfbd6830076d5c9d404df855f9c356b0b347b4c9c077d"

  def install
    bin.install "caddy-security"
  end

  test do
    system "#{bin}/caddy-security"
  end
end
