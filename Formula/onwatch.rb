class Onwatch < Formula
  desc "Track AI API quotas across Synthetic, Z.ai, Anthropic (Claude Code), Codex, GitHub Copilot"
  homepage "https://example.org/onwatch"
  version "2.14.16"
  url "http://127.0.0.1:8080/brew/bottles/onwatch--2.14.16.loongarch64.bottle.tar.gz"
  sha256 "e71b398bc38157296546d96511f23a2c329d5bb93c0b0ab25c6e2b3639b6fe75"

  def install
    bin.install "onwatch"
  end

  test do
    system "#{bin}/onwatch"
  end
end
