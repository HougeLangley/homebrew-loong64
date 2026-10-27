class Git-scope < Formula
  desc "A fast TUI to see the status of all git repositories on your machine."
  homepage "https://example.org/git-scope"
  version "1.4.0"
  url "http://127.0.0.1:8080/brew/bottles/git-scope--1.4.0.loongarch64.bottle.tar.gz"
  sha256 "527c853e8eacc67fcb43156eafe7532b39918239ff149b7029f052616bfa5518"

  def install
    bin.install "git-scope"
  end

  test do
    system "#{bin}/git-scope"
  end
end
