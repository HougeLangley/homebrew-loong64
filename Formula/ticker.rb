class Ticker < Formula
  desc "Track stocks, crypto, and derivatives prices and positions in real time from your terminal"
  homepage "https://example.org/ticker"
  version "5.3.0"
  url "http://127.0.0.1:8080/brew/bottles/ticker--5.3.0.loongarch64.bottle.tar.gz"
  sha256 "a5f864a45fda630412582a831430f17c2378ca0d1c25b3f6c4b74fcb125a787d"

  def install
    bin.install "ticker"
  end

  test do
    system "#{bin}/ticker"
  end
end
