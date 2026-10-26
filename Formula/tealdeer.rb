class Tealdeer < Formula
  desc "Fast tldr client"
  homepage "https://example.org/tealdeer"
  version "1.9.1"
  url "http://127.0.0.1:8080/brew/bottles/tealdeer--1.9.1.loongarch64.bottle.tar.gz"
  sha256 "083bb64f415ef80d85d97635ce0947d4b79cc20a114e893f80e5ae14315c67c4"

  def install
    bin.install "tealdeer"
  end

  test do
    system "#{bin}/tealdeer"
  end
end
