class Asnmap < Formula
  desc "Quickly map organization network ranges using ASN information"
  homepage "https://example.org/asnmap"
  version "1.2.0"
  url "http://127.0.0.1:8080/brew/bottles/asnmap--1.2.0.loongarch64.bottle.tar.gz"
  sha256 "87b11a09be4cb3d2735a42abcd431444231b17ad9b96818c1d3fc570f3dabe77"

  def install
    bin.install "asnmap"
  end

  test do
    system "#{bin}/asnmap"
  end
end
