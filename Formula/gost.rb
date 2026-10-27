class Gost < Formula
  desc "GO Simple Tunnel - a simple tunnel written in golang"
  homepage "https://example.org/gost"
  version "3.3.1"
  url "http://127.0.0.1:8080/brew/bottles/gost--3.3.1.loongarch64.bottle.tar.gz"
  sha256 "f95e4f0cf432f4da3cef2d80d0a12dd2805a891692ce4a9fb09af68bd83f5a6d"

  def install
    bin.install "gost"
  end

  test do
    system "#{bin}/gost"
  end
end
