class Mayhem < Formula
  desc "A minimal TUI based task tracker 📝"
  homepage "https://example.org/mayhem"
  version "1.2.4"
  url "http://127.0.0.1:8080/brew/bottles/mayhem--1.2.4.loongarch64.bottle.tar.gz"
  sha256 "ea602b0b4cc95259809c8483c6d6dfa1a3b488130e4ee0082d51bfe01f918b35"

  def install
    bin.install "mayhem"
  end

  test do
    system "#{bin}/mayhem"
  end
end
