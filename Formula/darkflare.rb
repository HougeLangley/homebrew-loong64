class Darkflare < Formula
  desc "DarkFlare Firewall Piercing (TCP over CDN)"
  homepage "https://example.org/darkflare"
  version "1.3.3"
  url "http://127.0.0.1:8080/brew/bottles/darkflare--1.3.3.loongarch64.bottle.tar.gz"
  sha256 "e3b45ce87d4fbf0d90327b57431b103fe034c7c41d8353af563fbac81dba2d76"

  def install
    bin.install "darkflare"
  end

  test do
    system "#{bin}/darkflare"
  end
end
