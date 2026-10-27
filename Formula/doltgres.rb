class Doltgres < Formula
  desc "Dolt for Postgres"
  homepage "https://example.org/doltgres"
  version "1.4.0"
  url "http://127.0.0.1:8080/brew/bottles/doltgres--1.4.0.loongarch64.bottle.tar.gz"
  sha256 "4b940855f50b09fd0373a3c2ff333eac2a91ccaaa5a916c6393d0d0b2fada549"

  def install
    bin.install "doltgres"
  end

  test do
    system "#{bin}/doltgres"
  end
end
