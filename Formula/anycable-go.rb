class Anycable-go < Formula
  desc "WebSocket server with action cable protocol"
  homepage "https://example.org/anycable-go"
  version "1.6.20"
  url "http://127.0.0.1:8080/brew/bottles/anycable-go--1.6.20.loongarch64.bottle.tar.gz"
  sha256 "41de4a02ddf14394b60dd8feef16570ece86110264c83e7d5266f796d966dbdd"

  def install
    bin.install "anycable-go"
  end

  test do
    system "#{bin}/anycable-go"
  end
end
