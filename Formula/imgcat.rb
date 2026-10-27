class Imgcat < Formula
  desc "Display images and gifs in your terminal."
  homepage "https://example.org/imgcat"
  version "1.0.23"
  url "http://127.0.0.1:8080/brew/bottles/imgcat--1.0.23.loongarch64.bottle.tar.gz"
  sha256 "6962501e0dac405a3df25f37d82bee1faccab377c7f12fa754630466eb32d626"

  def install
    bin.install "imgcat"
  end

  test do
    system "#{bin}/imgcat"
  end
end
