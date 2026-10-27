class Mcp-publisher < Formula
  desc "Publisher CLI tool for the Official Model Context Protocol (MCP) Registry"
  homepage "https://example.org/mcp-publisher"
  version "1.8.5"
  url "http://127.0.0.1:8080/brew/bottles/mcp-publisher--1.8.5.loongarch64.bottle.tar.gz"
  sha256 "8ffa9ad3f18ae4612abc8e2ce4a32a7a9f264415a666979a0a8dd9c46b39e161"

  def install
    bin.install "mcp-publisher"
  end

  test do
    system "#{bin}/mcp-publisher"
  end
end
