class Morph < Formula
  desc "NixOS deployment tool"
  homepage "https://example.org/morph"
  version "1.8.0"
  url "http://127.0.0.1:8080/brew/bottles/morph--1.8.0.loongarch64.bottle.tar.gz"
  sha256 "e8d7288d7d930adddb64856547ce25dd2ebb333f4d5b6c786295f17b0c940630"

  def install
    bin.install "morph"
  end

  test do
    system "#{bin}/morph"
  end
end
