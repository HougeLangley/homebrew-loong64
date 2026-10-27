class Cql < Formula
  desc "Decentralized SQL database with blockchain features"
  homepage "https://example.org/cql"
  version "0.8.1"
  url "http://127.0.0.1:8080/brew/bottles/cql--0.8.1.loongarch64.bottle.tar.gz"
  sha256 "50a68d5d1582a018e726ccc6094c6d2513ac2fceefb4412ba509a1d53e98ed02"

  def install
    bin.install "cql"
  end

  test do
    system "#{bin}/cql"
  end
end
