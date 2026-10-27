class Static-server < Formula
  desc "A simple, zero-configuration HTTP server CLI for serving static files"
  homepage "https://example.org/static-server"
  version "1.4.0"
  url "http://127.0.0.1:8080/brew/bottles/static-server--1.4.0.loongarch64.bottle.tar.gz"
  sha256 "7b728da17520fd7a8cdd8d0c15e32fa13631f04944b77794ea9875b26e696967"

  def install
    bin.install "static-server"
  end

  test do
    system "#{bin}/static-server"
  end
end
