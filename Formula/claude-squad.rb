class Claude-squad < Formula
  desc "Manage multiple AI terminal agents like Claude Code, Codex, OpenCode, and Amp."
  homepage "https://example.org/claude-squad"
  version "1.0.20"
  url "http://127.0.0.1:8080/brew/bottles/claude-squad--1.0.20.loongarch64.bottle.tar.gz"
  sha256 "8c75035188630958971231061220df48c8b5445168d53aac744cb17b0875a3ba"

  def install
    bin.install "claude-squad"
  end

  test do
    system "#{bin}/claude-squad"
  end
end
