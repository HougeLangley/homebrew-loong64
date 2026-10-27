class Goanime < Formula
  desc "Search, stream and download anime, movies and TV shows from the terminal, in English and B"
  homepage "https://example.org/goanime"
  version "1.8.7"
  url "http://127.0.0.1:8080/brew/bottles/goanime--1.8.7.loongarch64.bottle.tar.gz"
  sha256 "0979867fcb6722d4a77f689894d9689fb120709cc2cb28d57ec4f1281d9c9cbb"

  def install
    bin.install "goanime"
  end

  test do
    system "#{bin}/goanime"
  end
end
