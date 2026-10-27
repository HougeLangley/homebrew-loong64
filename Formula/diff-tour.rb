class Diff-tour < Formula
  desc "Walk through a diff the way a senior engineer reads it. A read-only TUI that turns a git c"
  homepage "https://example.org/diff-tour"
  version "0.6.0"
  url "http://127.0.0.1:8080/brew/bottles/diff-tour--0.6.0.loongarch64.bottle.tar.gz"
  sha256 "824be760d8c715d7c59245fe37f91f4f4395bdccccba8224c37dc2f6aaba2eb0"

  def install
    bin.install "diff-tour"
  end

  test do
    system "#{bin}/diff-tour"
  end
end
