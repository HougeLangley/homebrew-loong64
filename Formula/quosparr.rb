class Quosparr < Formula
  desc "🐦 Native menu bar & tray app for macOS, Windows and Linux: track Codex, Claude Code and Gr"
  homepage "https://example.org/quosparr"
  version "1.9.4"
  url "http://127.0.0.1:8080/brew/bottles/quosparr--1.9.4.loongarch64.bottle.tar.gz"
  sha256 "8ccba9801dd8c8d964d604fd0585ab0b45577a6d1ba7aa5d1f70b6807eb8f147"

  def install
    bin.install "quosparr"
  end

  test do
    system "#{bin}/quosparr"
  end
end
