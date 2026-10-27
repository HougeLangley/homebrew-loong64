class Cc9s < Formula
  desc "A k9s-inspired CLI and TUI for managing Claude Code sessions — browse, search, inspect, an"
  homepage "https://example.org/cc9s"
  version "0.2.3"
  url "http://127.0.0.1:8080/brew/bottles/cc9s--0.2.3.loongarch64.bottle.tar.gz"
  sha256 "af3107261d5909e86334ad3c10ec34e85cae33353f829cf295dc2a6dd82534c6"

  def install
    bin.install "cc9s"
  end

  test do
    system "#{bin}/cc9s"
  end
end
