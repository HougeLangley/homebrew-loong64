class Gh-stack < Formula
  desc "GitHub Stacked PRs"
  homepage "https://example.org/gh-stack"
  version "0.3.0"
  url "http://127.0.0.1:8080/brew/bottles/gh-stack--0.3.0.loongarch64.bottle.tar.gz"
  sha256 "0b85ae3e56dbb427478893eaaea78e497fdccda054c3c5bbc35cedb560d10fcc"

  def install
    bin.install "gh-stack"
  end

  test do
    system "#{bin}/gh-stack"
  end
end
