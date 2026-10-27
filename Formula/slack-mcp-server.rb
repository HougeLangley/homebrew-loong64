class Slack-mcp-server < Formula
  desc "Powerful MCP Slack Server with multiple transports and smart history fetch logic"
  homepage "https://example.org/slack-mcp-server"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/slack-mcp-server--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "f65a9e8071f8d734795511c8678a9d9bf7575283f26e3c2ffca90a2e4bf62ce3"

  def install
    bin.install "slack-mcp-server"
  end

  test do
    system "#{bin}/slack-mcp-server"
  end
end
