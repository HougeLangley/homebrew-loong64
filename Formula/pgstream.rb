class Pgstream < Formula
  desc "PostgreSQL replication with DDL changes"
  homepage "https://example.org/pgstream"
  version "1.5.0"
  url "http://127.0.0.1:8080/brew/bottles/pgstream--1.5.0.loongarch64.bottle.tar.gz"
  sha256 "22edbddca76183a15753b3ddd57fe11911a2672413d555317bb12fd706d22d82"

  def install
    bin.install "pgstream"
  end

  test do
    system "#{bin}/pgstream"
  end
end
