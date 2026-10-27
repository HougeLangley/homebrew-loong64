class Git-hooks < Formula
  desc "git hooks manager"
  homepage "https://example.org/git-hooks"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/git-hooks--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "c6cadbf08ecad1ae892e7671169755c9c4b2368c6e2b73533c23594341558367"

  def install
    bin.install "git-hooks"
  end

  test do
    system "#{bin}/git-hooks"
  end
end
