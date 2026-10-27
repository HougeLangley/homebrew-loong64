class Func-e < Formula
  desc "Easily run Envoy"
  homepage "https://example.org/func-e"
  version "1.6.0"
  url "http://127.0.0.1:8080/brew/bottles/func-e--1.6.0.loongarch64.bottle.tar.gz"
  sha256 "5709aa6f3c314c734b17c96f6ab10d7494d13eae87324421893acf3abba7f3fb"

  def install
    bin.install "func-e"
  end

  test do
    system "#{bin}/func-e"
  end
end
