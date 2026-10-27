class Uncover < Formula
  desc "Quickly discover exposed hosts on the internet using multiple search engines."
  homepage "https://example.org/uncover"
  version "1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/uncover--1.2.1.loongarch64.bottle.tar.gz"
  sha256 "ff2674799bd5546b6d4bb38a4584cd6819bab916cc620dfa0134f0e361b3c573"

  def install
    bin.install "uncover"
  end

  test do
    system "#{bin}/uncover"
  end
end
