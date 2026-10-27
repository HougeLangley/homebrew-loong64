class Deck < Formula
  desc "Creates slide deck using Markdown and Google Slides"
  homepage "https://example.org/deck"
  version "1.24.4"
  url "http://127.0.0.1:8080/brew/bottles/deck--1.24.4.loongarch64.bottle.tar.gz"
  sha256 "67778e2c99accf4c17292a771b8b28eec1d9e1872b7791b70e9f16c118d699ae"

  def install
    bin.install "deck"
  end

  test do
    system "#{bin}/deck"
  end
end
