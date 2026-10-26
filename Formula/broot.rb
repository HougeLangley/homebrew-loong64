class Broot < Formula
  desc "Interactive tree navigation"
  homepage "https://example.org/broot"
  version "1.61.0"
  url "http://127.0.0.1:8080/brew/bottles/broot--1.61.0.loongarch64.bottle.tar.gz"
  sha256 "a12aeba9a47fe29f4474b00bd27e16e26c7903e27ca84f7d9ef90d71e3ba19b8"

  def install
    bin.install "broot"
  end

  test do
    system "#{bin}/broot"
  end
end
