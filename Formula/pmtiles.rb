class Pmtiles < Formula
  desc "Single-file executable tool for creating, reading and uploading PMTiles archives"
  homepage "https://example.org/pmtiles"
  version "1.31.2"
  url "http://127.0.0.1:8080/brew/bottles/pmtiles--1.31.2.loongarch64.bottle.tar.gz"
  sha256 "15cadd8d14607b0b1b73d4f1787eb96d16bffcb4e26541db54cd77a5e56df45c"

  def install
    bin.install "pmtiles"
  end

  test do
    system "#{bin}/pmtiles"
  end
end
