class Pg-schema-diff < Formula
  desc "Diff Postgres schemas and generating SQL migrations"
  homepage "https://example.org/pg-schema-diff"
  version "1.0.9"
  url "http://127.0.0.1:8080/brew/bottles/pg-schema-diff--1.0.9.loongarch64.bottle.tar.gz"
  sha256 "69e531f5ef3936c6e642993d847c476c30c8dc94232ed5424f71d3b6df8ea83f"

  def install
    bin.install "pg-schema-diff"
  end

  test do
    system "#{bin}/pg-schema-diff"
  end
end
