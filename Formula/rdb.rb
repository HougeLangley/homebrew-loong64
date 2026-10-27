class Rdb < Formula
  desc "Redis RDB parser"
  homepage "https://example.org/rdb"
  version "1.3.2"
  url "http://127.0.0.1:8080/brew/bottles/rdb--1.3.2.loongarch64.bottle.tar.gz"
  sha256 "918a8732e7daa0523b5553be2ef29682010f3e513bbda8313421a9bd047b90eb"

  def install
    bin.install "rdb"
  end

  test do
    system "#{bin}/rdb"
  end
end
