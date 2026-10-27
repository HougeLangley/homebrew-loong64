class Pgschema < Formula
  desc "Terraform-style, declarative Postgres schema migration. Agent friendly."
  homepage "https://example.org/pgschema"
  version "1.13.3"
  url "http://127.0.0.1:8080/brew/bottles/pgschema--1.13.3.loongarch64.bottle.tar.gz"
  sha256 "85d1617d455eb0cad7aaa9a0bb8fa2145f316d8159d544a41c10c006b1a6d5b5"

  def install
    bin.install "pgschema"
  end

  test do
    system "#{bin}/pgschema"
  end
end
