class Pixiv-cli < Formula
  desc "Pixiv, in your terminal — a CLI, MCP server, and Go SDK for discovery, accounts, creators,"
  homepage "https://example.org/pixiv-cli"
  version "1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/pixiv-cli--1.2.1.loongarch64.bottle.tar.gz"
  sha256 "b21f588e733857178ea25bdd51cd0d9d26e1296672422a8dc95c2bd45d2b2c1f"

  def install
    bin.install "pixiv-cli"
  end

  test do
    system "#{bin}/pixiv-cli"
  end
end
