class Chop < Formula
  desc "CLI output compressor for Claude Code. Reduces token consumption by 50–90% by compressing "
  homepage "https://example.org/chop"
  version "1.39.5"
  url "http://127.0.0.1:8080/brew/bottles/chop--1.39.5.loongarch64.bottle.tar.gz"
  sha256 "f21392e8a16a784074538e01406c1c6bfb7f6aee1f95f37037b66d9f0353c9b6"

  def install
    bin.install "chop"
  end

  test do
    system "#{bin}/chop"
  end
end
