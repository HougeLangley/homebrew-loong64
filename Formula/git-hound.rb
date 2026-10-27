class Git-hound < Formula
  desc "Git plugin that prevents sensitive data from being committed."
  homepage "https://example.org/git-hound"
  version "1.0.0"
  url "http://127.0.0.1:8080/brew/bottles/git-hound--1.0.0.loongarch64.bottle.tar.gz"
  sha256 "7ff21bace64a5f0aedc52947790e363f5981a4f386a0c1331560e396d7c15030"

  def install
    bin.install "git-hound"
  end

  test do
    system "#{bin}/git-hound"
  end
end
