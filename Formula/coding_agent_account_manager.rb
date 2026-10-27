class Coding_agent_account_manager < Formula
  desc "Sub-100ms auth switching for AI coding CLIs (Claude Code, Codex, Gemini, Grok, Cursor, and"
  homepage "https://example.org/coding_agent_account_manager"
  version "0.1.24"
  url "http://127.0.0.1:8080/brew/bottles/coding_agent_account_manager--0.1.24.loongarch64.bottle.tar.gz"
  sha256 "d98f997c37537c75ba48b1bf7e85723148888b2bc42a5c2be08c76d4bdcceb24"

  def install
    bin.install "coding_agent_account_manager"
  end

  test do
    system "#{bin}/coding_agent_account_manager"
  end
end
