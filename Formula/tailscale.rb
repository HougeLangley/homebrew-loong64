class Tailscale < Formula
  desc "Easiest, most secure way to use WireGuard and 2FA"
  homepage "https://example.org/tailscale"
  version "1.104.2"
  url "http://127.0.0.1:8080/brew/bottles/tailscale--1.104.2.loongarch64.bottle.tar.gz"
  sha256 "67e0908f95a1c0f3e358f1e309443d7faa435dacfa39c5027428346a01dbc315"

  def install
    bin.install "tailscale"
  end

  test do
    system "#{bin}/tailscale"
  end
end
