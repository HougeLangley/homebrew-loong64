class Drip < Formula
  desc "Self-hosted tunneling solution to expose localhost securely - unlimited bandwidth, no thir"
  homepage "https://example.org/drip"
  version "0.8.1"
  url "http://127.0.0.1:8080/brew/bottles/drip--0.8.1.loongarch64.bottle.tar.gz"
  sha256 "8c8fea3ef127aba567db8374975d78f2f03733e481934da3a58bbe5610c209d4"

  def install
    bin.install "drip"
  end

  test do
    system "#{bin}/drip"
  end
end
