class Mcp-toolbox < Formula
  desc "MCP server for databases"
  homepage "https://example.org/mcp-toolbox"
  version "1.15.0"
  url "http://127.0.0.1:8080/brew/bottles/mcp-toolbox--1.15.0.loongarch64.bottle.tar.gz"
  sha256 "31a6ae46ba0b8cffb8b09d8825f8b34b2d57915615f2d4bdf6d119d24203911d"

  def install
    bin.install "mcp-toolbox"
  end

  test do
    system "#{bin}/mcp-toolbox"
  end
end
