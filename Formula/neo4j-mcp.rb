class Neo4j-mcp < Formula
  desc "Neo4j official Model Context Protocol server for AI tools"
  homepage "https://example.org/neo4j-mcp"
  version "1.6.1"
  url "http://127.0.0.1:8080/brew/bottles/neo4j-mcp--1.6.1.loongarch64.bottle.tar.gz"
  sha256 "6b2391ee9cd4395a3e5c1eaea5a5cd850622d9992e5ca7a4a334bca33a62cf9f"

  def install
    bin.install "neo4j-mcp"
  end

  test do
    system "#{bin}/neo4j-mcp"
  end
end
