class Sampctl < Formula
  desc "The Swiss Army Knife of SA:MP - vital tools for any server owner or library maintainer."
  homepage "https://example.org/sampctl"
  version "1.16.0"
  url "http://127.0.0.1:8080/brew/bottles/sampctl--1.16.0.loongarch64.bottle.tar.gz"
  sha256 "22d096de6465a5d1d7379880d8ab6eb17896984b2a89aa21d3d9e31abe6df646"

  def install
    bin.install "sampctl"
  end

  test do
    system "#{bin}/sampctl"
  end
end
