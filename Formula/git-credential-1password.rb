class Git-credential-1password < Formula
  desc "A Git credential helper that utilizes the 1Password CLI to authenticate a Git over http(s)"
  homepage "https://example.org/git-credential-1password"
  version "1.5.0"
  url "http://127.0.0.1:8080/brew/bottles/git-credential-1password--1.5.0.loongarch64.bottle.tar.gz"
  sha256 "84e76b3b45f17e5fd0ad51b29eb6f0644426d0d34df91bba8c30c55bfe6668c8"

  def install
    bin.install "git-credential-1password"
  end

  test do
    system "#{bin}/git-credential-1password"
  end
end
