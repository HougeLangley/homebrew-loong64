class Gentle-ai < Formula
  desc "Gentle-AI configures the AI coding agents you already use: Claude Code, Cursor, OpenCode, "
  homepage "https://example.org/gentle-ai"
  version "4.2.0"
  url "http://127.0.0.1:8080/brew/bottles/gentle-ai--4.2.0.loongarch64.bottle.tar.gz"
  sha256 "2026863df9455bad7093545f89ee8b67e0a3b538b3ad85b889c78b70bdf1ee5e"

  def install
    bin.install "gentle-ai"
  end

  test do
    system "#{bin}/gentle-ai"
  end
end
