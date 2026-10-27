class Lazyagent < Formula
  desc "Monitor all your coding agents from one terminal - Claude Code, Cursor, OpenCode, pi and m"
  homepage "https://example.org/lazyagent"
  version "0.15.9"
  url "http://127.0.0.1:8080/brew/bottles/lazyagent--0.15.9.loongarch64.bottle.tar.gz"
  sha256 "7ff729356660189b623d62bd172aca3a48d53a1086ad652b4a8a43fb50bc9f49"

  def install
    bin.install "lazyagent"
  end

  test do
    system "#{bin}/lazyagent"
  end
end
