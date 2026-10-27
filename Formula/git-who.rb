class Git-who < Formula
  desc "Git blame for file trees"
  homepage "https://example.org/git-who"
  version "1.3"
  url "http://127.0.0.1:8080/brew/bottles/git-who--1.3.loongarch64.bottle.tar.gz"
  sha256 "a2ee5ebdaa10ab942cea46b608b3dc2f8f8da5fffbb5fcf4bdd1f25c8bd64f71"

  def install
    bin.install "git-who"
  end

  test do
    system "#{bin}/git-who"
  end
end
