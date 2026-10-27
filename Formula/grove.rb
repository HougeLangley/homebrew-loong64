class Grove < Formula
  desc "Git worktree workspace orchestrator. One command creates a workspace folder with worktrees"
  homepage "https://example.org/grove"
  version "1.1.20"
  url "http://127.0.0.1:8080/brew/bottles/grove--1.1.20.loongarch64.bottle.tar.gz"
  sha256 "391c8b89213662158d03b8c7f9b0f72d9556b7d5c76c79e4ca17b0efa80970bb"

  def install
    bin.install "grove"
  end

  test do
    system "#{bin}/grove"
  end
end
