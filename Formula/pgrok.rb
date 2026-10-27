class Pgrok < Formula
  desc "Poor man's ngrok - a multi-tenant HTTP/TCP reverse tunnel solution through SSH remote port"
  homepage "https://example.org/pgrok"
  version "1.7.0"
  url "http://127.0.0.1:8080/brew/bottles/pgrok--1.7.0.loongarch64.bottle.tar.gz"
  sha256 "139fb09280d805271b6be1883305f5b04cec83c38c48a3dc5f3174c17f4755cc"

  def install
    bin.install "pgrok"
  end

  test do
    system "#{bin}/pgrok"
  end
end
