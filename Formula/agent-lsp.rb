class Agent-lsp < Formula
  desc "MCP server that orchestrates language servers into agent-native workflows. 65 tools, 30 CI"
  homepage "https://example.org/agent-lsp"
  version "0.23.4"
  url "http://127.0.0.1:8080/brew/bottles/agent-lsp--0.23.4.loongarch64.bottle.tar.gz"
  sha256 "2ef6ab0951f3af2a3f89a1145eb5b632186c7cc90df87a3a9ff68557dd37219f"

  def install
    bin.install "agent-lsp"
  end

  test do
    system "#{bin}/agent-lsp"
  end
end
