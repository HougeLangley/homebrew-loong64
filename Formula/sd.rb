class Sd < Formula
  desc "Intuitive find and replace CLI"
  homepage "https://example.org/sd"
  version "1.1.0"
  url "http://127.0.0.1:8080/brew/bottles/sd--1.1.0.loongarch64.bottle.tar.gz"
  sha256 "626242bdf11d4287f439da190391285ebb131105e60fc0c6c6cce65a8111284b"

  def install
    bin.install "sd"
  end

  test do
    system "#{bin}/sd"
  end
end
