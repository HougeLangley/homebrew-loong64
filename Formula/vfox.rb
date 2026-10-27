class Vfox < Formula
  desc "A cross-platform and extendable version manager with support for Java, Node.js, Golang, Py"
  homepage "https://example.org/vfox"
  version "1.0.13"
  url "http://127.0.0.1:8080/brew/bottles/vfox--1.0.13.loongarch64.bottle.tar.gz"
  sha256 "a786d5c8a07acd0bb6f73cde27bc69cd26331aee98e40b39cb70f69c89b1762f"

  def install
    bin.install "vfox"
  end

  test do
    system "#{bin}/vfox"
  end
end
