class Goshs < Formula
  desc "Simple, yet feature-rich web server written in Go"
  homepage "https://example.org/goshs"
  version "2.1.7"
  url "http://127.0.0.1:8080/brew/bottles/goshs--2.1.7.loongarch64.bottle.tar.gz"
  sha256 "5bbc3e38ee8083dbc8a2529440ad87ce72b1a0e0909f75d70789f22cd8d0c5e1"

  def install
    bin.install "goshs"
  end

  test do
    system "#{bin}/goshs"
  end
end
