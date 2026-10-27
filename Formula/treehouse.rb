class Treehouse < Formula
  desc "Manage worktrees without managing worktrees."
  homepage "https://example.org/treehouse"
  version "3.1.7"
  url "http://127.0.0.1:8080/brew/bottles/treehouse--3.1.7.loongarch64.bottle.tar.gz"
  sha256 "8c34609a0f31f5eb7a5c5c9a207c55c1bb2d2ae5b375d239a7ad86db64261b52"

  def install
    bin.install "treehouse"
  end

  test do
    system "#{bin}/treehouse"
  end
end
