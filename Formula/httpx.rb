class Httpx < Formula
  desc "httpx is a fast and multi-purpose HTTP toolkit that allows running multiple probes using t"
  homepage "https://example.org/httpx"
  version "1.12.0"
  url "http://127.0.0.1:8080/brew/bottles/httpx--1.12.0.loongarch64.bottle.tar.gz"
  sha256 "847d1bbbb7d85c285233eaa98195c71f796d8696f2547103cccc33f358b5f1e2"

  def install
    bin.install "httpx"
  end

  test do
    system "#{bin}/httpx"
  end
end
