class Just < Formula
  desc "Just a command runner"
  homepage "https://example.org/just"
  version "1.59.0"
  url "http://127.0.0.1:8080/brew/bottles/just--1.59.0.loongarch64.bottle.tar.gz"
  sha256 "f8911a8721062ea7f0162eaf39b56a2bb04e65b68b9702204d4f5b3976837413"

  def install
    bin.install "just"
  end

  test do
    system "#{bin}/just"
  end
end
