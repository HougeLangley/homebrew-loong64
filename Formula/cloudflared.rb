class Cloudflared < Formula
  desc "Cloudflare Tunnel client (formerly Argo Tunnel)"
  homepage "https://example.org/cloudflared"
  version "2026.10.4"
  url "http://127.0.0.1:8080/brew/bottles/cloudflared--2026.10.4.loongarch64.bottle.tar.gz"
  sha256 "998b42b9fd1431357fa28d1dba34106b9023fb1c13a8243d38f1501c29c48c44"

  def install
    bin.install "cloudflared"
  end

  test do
    system "#{bin}/cloudflared"
  end
end
