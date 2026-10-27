class Cfssl < Formula
  desc "CloudFlare's PKI toolkit"
  homepage "https://example.org/cfssl"
  version "1.7.1"
  url "http://127.0.0.1:8080/brew/bottles/cfssl--1.7.1.loongarch64.bottle.tar.gz"
  sha256 "28323a30770ab2f3606152d23bf789c8a91b98b3ed175a4a7591e578208da10f"

  def install
    bin.install "cfssl"
  end

  test do
    system "#{bin}/cfssl"
  end
end
