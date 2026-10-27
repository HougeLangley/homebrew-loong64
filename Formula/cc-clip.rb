class Cc-clip < Formula
  desc "Paste images into remote Claude Code & Codex CLI over SSH — clipboard bridging for macOS a"
  homepage "https://example.org/cc-clip"
  version "0.13.1"
  url "http://127.0.0.1:8080/brew/bottles/cc-clip--0.13.1.loongarch64.bottle.tar.gz"
  sha256 "0596b1efed663511ab8b483ad796811c5c5a12359a8d2109b33ec39cd20bde2a"

  def install
    bin.install "cc-clip"
  end

  test do
    system "#{bin}/cc-clip"
  end
end
