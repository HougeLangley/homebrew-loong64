class Gotags < Formula
  desc "Tag generator for Go, compatible with ctags"
  homepage "https://example.org/gotags"
  version "1.4.1"
  url "http://127.0.0.1:8080/brew/bottles/gotags--1.4.1.loongarch64.bottle.tar.gz"
  sha256 "1ae8040d9a8a3c13d069ec74314b8de3e1c94dfe77b958ae7f2a52037efaf03d"

  def install
    bin.install "gotags"
  end

  test do
    system "#{bin}/gotags"
  end
end
