class Sqlc < Formula
  desc "Generate type safe Go from SQL"
  homepage "https://example.org/sqlc"
  version "1.31.1"
  url "http://127.0.0.1:8080/brew/bottles/sqlc--1.31.1.loongarch64.bottle.tar.gz"
  sha256 "3bcea146a473af0d12618e5edd72b3acafebe6248ec00369f6982acd76e198cd"

  def install
    bin.install "sqlc"
  end

  test do
    system "#{bin}/sqlc"
  end
end
