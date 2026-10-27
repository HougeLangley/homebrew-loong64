class Slack-mcp-server < Formula
  desc "Powerful MCP Slack Server with multiple transports and smart history fetch logic"
  homepage "https://example.org/slack-mcp-server"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/slack-mcp-server--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "336ae44a4a0d215fb99ecc5469c4441d8b221296e8fb84956a0976657f5fc3be"

  def install
    bin.install "slack-mcp-server"
  end

  test do
    system "#{bin}/slack-mcp-server"
  end
end
