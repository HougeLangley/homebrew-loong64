class Rekor < Formula
  desc "Software Supply Chain Transparency Log"
  homepage "https://example.org/rekor"
  version "1.5.5"
  url "http://127.0.0.1:8080/brew/bottles/rekor--1.5.5.loongarch64.bottle.tar.gz"
  sha256 "63577a45e1043c4e70ffc83e9f54969a578877b29877ef8a5681ef8be2d40e12"

  def install
    bin.install "rekor"
  end

  test do
    system "#{bin}/rekor"
  end
end
