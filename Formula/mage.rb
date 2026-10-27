class Mage < Formula
  desc "Make/rake-like build tool using Go"
  homepage "https://example.org/mage"
  version "1.17.2"
  url "http://127.0.0.1:8080/brew/bottles/mage--1.17.2.loongarch64.bottle.tar.gz"
  sha256 "dff55eaaab8016193d4fde135def30ce943812bb3e1d5735bf148e920e414668"

  def install
    bin.install "mage"
  end

  test do
    system "#{bin}/mage"
  end
end
