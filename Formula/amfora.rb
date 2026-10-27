class Amfora < Formula
  desc "A fancy terminal browser for the Gemini protocol."
  homepage "https://example.org/amfora"
  version "1.11.0"
  url "http://127.0.0.1:8080/brew/bottles/amfora--1.11.0.loongarch64.bottle.tar.gz"
  sha256 "27b81bf852f2df71cf9ca184b044811b92ae55e4b55853e20268b01772fdc18b"

  def install
    bin.install "amfora"
  end

  test do
    system "#{bin}/amfora"
  end
end
