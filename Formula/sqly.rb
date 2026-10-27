class Sqly < Formula
  desc "executes SQL against CSV, TSV, LTSV, JSON, JSONL, Parquet, Microsoft Excel™ , ACH, and Fed"
  homepage "https://example.org/sqly"
  version "1.7.3"
  url "http://127.0.0.1:8080/brew/bottles/sqly--1.7.3.loongarch64.bottle.tar.gz"
  sha256 "9f3dc7dca3dbaa3650020d59490a21ad178a97cbd88fcebfa6149a8334fd5afe"

  def install
    bin.install "sqly"
  end

  test do
    system "#{bin}/sqly"
  end
end
