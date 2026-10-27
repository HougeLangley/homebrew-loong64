class Gh-pr-review < Formula
  desc "GitHub CLI extension that adds full inline PR review comment support — view, navigate, rep"
  homepage "https://example.org/gh-pr-review"
  version "1.6.2"
  url "http://127.0.0.1:8080/brew/bottles/gh-pr-review--1.6.2.loongarch64.bottle.tar.gz"
  sha256 "afc8f25da5699c1b768285cdeda0d8033af5d8c6a22d4e5733deefe711b39821"

  def install
    bin.install "gh-pr-review"
  end

  test do
    system "#{bin}/gh-pr-review"
  end
end
