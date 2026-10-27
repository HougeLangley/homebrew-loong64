class Gf < Formula
  desc "A powerful framework for faster, easier, and more efficient project development."
  homepage "https://example.org/gf"
  version "2.10.3"
  url "http://127.0.0.1:8080/brew/bottles/gf--2.10.3.loongarch64.bottle.tar.gz"
  sha256 "e92283d5d8eb524091e542ffc7d02008d0b92ac550799bd3ee417242b8bef052"

  def install
    bin.install "gf"
  end

  test do
    system "#{bin}/gf"
  end
end
