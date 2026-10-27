class Mcp-1c < Formula
  desc "MCP server for 1С:Enterprise — AI assistant sees your configuration and generates accurate"
  homepage "https://example.org/mcp-1c"
  version "1.23.0"
  url "http://127.0.0.1:8080/brew/bottles/mcp-1c--1.23.0.loongarch64.bottle.tar.gz"
  sha256 "2d356a0fbd2f3ace83c01a0ec0e80ca8a3e04af146c0a0292bed0aafbae3592e"

  def install
    bin.install "mcp-1c"
  end

  test do
    system "#{bin}/mcp-1c"
  end
end
