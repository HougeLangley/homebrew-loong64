class Spaceinvaders-go < Formula
  desc "Space Invaders in your terminal written in Go"
  homepage "https://example.org/spaceinvaders-go"
  version "1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/spaceinvaders-go--1.2.1.loongarch64.bottle.tar.gz"
  sha256 "2b65100d7d505ffeffdddb266454da1e6dd5597f1016918f840e63b84fe9c75c"

  def install
    bin.install "spaceinvaders-go"
  end

  test do
    system "#{bin}/spaceinvaders-go"
  end
end
