class Shellescape < Formula
  desc "Escape arbitrary strings for use as command line arguments"
  homepage "https://example.org/shellescape"
  version "1.6.1"
  url "http://127.0.0.1:8080/brew/bottles/shellescape--1.6.1.loongarch64.bottle.tar.gz"
  sha256 "c2b99f1f0c4a243be72b394c2d7028f138127750586eb82d0d23706bcb677b62"

  def install
    bin.install "shellescape"
  end

  test do
    system "#{bin}/shellescape"
  end
end
