class Agent-notifications < Formula
  desc "🔔 Cross-platform smart notifications for Claude/Codex/OpenCode/Cursor/Gemini/Qoder. Deskto"
  homepage "https://example.org/agent-notifications"
  version "1.49.9"
  url "http://127.0.0.1:8080/brew/bottles/agent-notifications--1.49.9.loongarch64.bottle.tar.gz"
  sha256 "205dc3fa46cc4ad17feb95358185b8ef93f654a4a8d7e43bdfa313076495228d"

  def install
    bin.install "agent-notifications"
  end

  test do
    system "#{bin}/agent-notifications"
  end
end
