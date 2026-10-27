class Cliproxyapi < Formula
  desc "Wrap Gemini CLI, Codex, Claude Code, Qwen Code as an API service"
  homepage "https://example.org/cliproxyapi"
  version "8.0.44"
  url "http://127.0.0.1:8080/brew/bottles/cliproxyapi--8.0.44.loongarch64.bottle.tar.gz"
  sha256 "6c47fe367c137e574e758241a1f7d93b34577679795e744f908d106fe0ac4bc5"

  def install
    bin.install "cliproxyapi"
  end

  test do
    system "#{bin}/cliproxyapi"
  end
end
