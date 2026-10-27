class Agent-deck < Formula
  desc "Terminal session manager for AI coding agents. One TUI for Claude, Gemini, OpenCode, Codex"
  homepage "https://example.org/agent-deck"
  version "1.16.34"
  url "http://127.0.0.1:8080/brew/bottles/agent-deck--1.16.34.loongarch64.bottle.tar.gz"
  sha256 "d5f06bd472344a5dfb659e30734f6e4b41092c840ae829ac8daef0f175c4552d"

  def install
    bin.install "agent-deck"
  end

  test do
    system "#{bin}/agent-deck"
  end
end
