class Algolia < Formula
  desc "Command-line tool to manage Algolia applications, accounts, and search resources"
  homepage "https://example.org/algolia"
  version "1.18.0"
  url "http://127.0.0.1:8080/brew/bottles/algolia--1.18.0.loongarch64.bottle.tar.gz"
  sha256 "cda4bf38a479f16fe32bfbd86941c461eed98b7de98b7a2402ce7e450aaa6716"

  def install
    bin.install "algolia"
  end

  test do
    system "#{bin}/algolia"
  end
end
