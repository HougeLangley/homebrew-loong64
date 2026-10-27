class Shellz < Formula
  desc "Small utility to track and control custom shellz"
  homepage "https://example.org/shellz"
  version "1.6.0"
  url "http://127.0.0.1:8080/brew/bottles/shellz--1.6.0.loongarch64.bottle.tar.gz"
  sha256 "443e4308de15f173f07aa75b4aab5ddd1f6124fb8b5f6e393c3bb77763b6dfb6"

  def install
    bin.install "shellz"
  end

  test do
    system "#{bin}/shellz"
  end
end
