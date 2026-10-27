class Bzip2 < Formula
  desc "Block-sorting file compressor"
  homepage "https://example.org/bzip2"
  version "1.0.8"
  url "http://127.0.0.1:8080/brew/bottles/bzip2--1.0.8.loongarch64.bottle.tar.gz"
  sha256 "52e5e0ce693c3a5d5a35e17022785236594efb261453b888882fc6724b5ceeeb"

  def install
    bin.install "bzip2"
  end

  test do
    system "#{bin}/bzip2"
  end
end
