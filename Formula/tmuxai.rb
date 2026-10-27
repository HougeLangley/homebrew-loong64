class Tmuxai < Formula
  desc "AI-powered, non-intrusive terminal assistant"
  homepage "https://example.org/tmuxai"
  version "2.4.0"
  url "http://127.0.0.1:8080/brew/bottles/tmuxai--2.4.0.loongarch64.bottle.tar.gz"
  sha256 "1a7f89cc2aa67785d304f42dc7b747b9eba6e6410b09a5208170c819cda2795d"

  def install
    bin.install "tmuxai"
  end

  test do
    system "#{bin}/tmuxai"
  end
end
