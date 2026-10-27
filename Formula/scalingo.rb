class Scalingo < Formula
  desc "CLI for working with Scalingo's PaaS"
  homepage "https://example.org/scalingo"
  version "1.51.0"
  url "http://127.0.0.1:8080/brew/bottles/scalingo--1.51.0.loongarch64.bottle.tar.gz"
  sha256 "f29c77344875ac00c7d449caed7831b9e0dbad31ba2092423c93c7688cbc7c06"

  def install
    bin.install "scalingo"
  end

  test do
    system "#{bin}/scalingo"
  end
end
