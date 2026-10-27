class Bluemonday < Formula
  desc "bluemonday: a fast golang HTML sanitizer (inspired by the OWASP Java HTML Sanitizer) to sc"
  homepage "https://example.org/bluemonday"
  version "1.0.26"
  url "http://127.0.0.1:8080/brew/bottles/bluemonday--1.0.26.loongarch64.bottle.tar.gz"
  sha256 "376e9c86373ac936d581e4f5981bf1eda8fb0296e56c4f3cf524ddb33f6ed5f9"

  def install
    bin.install "bluemonday"
  end

  test do
    system "#{bin}/bluemonday"
  end
end
