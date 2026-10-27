class Pgbranch < Formula
  desc "Git style branching for local PostgreSQL "
  homepage "https://example.org/pgbranch"
  version "1.0.15"
  url "http://127.0.0.1:8080/brew/bottles/pgbranch--1.0.15.loongarch64.bottle.tar.gz"
  sha256 "7dd38d93a517f9652fae9924ce688f416ba848182065d2433d29b4f517a361d9"

  def install
    bin.install "pgbranch"
  end

  test do
    system "#{bin}/pgbranch"
  end
end
