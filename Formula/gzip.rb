class Gzip < Formula
  desc "GNU gzip compression utility"
  homepage "https://example.org/gzip"
  version "1.14"
  url "http://127.0.0.1:8080/brew/bottles/gzip--1.14.loongarch64.bottle.tar.gz"
  sha256 "9e57b90b7e6d881a667409ae04cc5d165e961df63fddc2ee739416369fe0e19c"

  def install
    bin.install "gzip"
  end

  test do
    system "#{bin}/gzip"
  end
end
