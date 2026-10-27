class Goclone < Formula
  desc "Website Cloner"
  homepage "https://example.org/goclone"
  version "1.2.2"
  url "http://127.0.0.1:8080/brew/bottles/goclone--1.2.2.loongarch64.bottle.tar.gz"
  sha256 "2594c948cb9b0d0a00125d4fb5d3eb3498f49abb483612a300c08fcd36c75586"

  def install
    bin.install "goclone"
  end

  test do
    system "#{bin}/goclone"
  end
end
