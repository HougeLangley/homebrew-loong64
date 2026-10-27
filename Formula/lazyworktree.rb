class Lazyworktree < Formula
  desc "Easy Git worktree management CLI and TUI for the terminal."
  homepage "https://example.org/lazyworktree"
  version "1.51.0"
  url "http://127.0.0.1:8080/brew/bottles/lazyworktree--1.51.0.loongarch64.bottle.tar.gz"
  sha256 "4e0c1b1c98e50247d584d27096a54d5846dfacaedd9c9768e6707be05fa7ef88"

  def install
    bin.install "lazyworktree"
  end

  test do
    system "#{bin}/lazyworktree"
  end
end
