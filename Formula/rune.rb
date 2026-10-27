class Rune < Formula
  desc "a fast, GPU-accelerated, full-featured IDE and terminal multiplexer, suitable both for aut"
  homepage "https://example.org/rune"
  version "1.3.2"
  url "http://127.0.0.1:8080/brew/bottles/rune--1.3.2.loongarch64.bottle.tar.gz"
  sha256 "a5a1f43e0383ef88ee4403e4f6b86542c37c020c46fa90b986d29125aaf21ba9"

  def install
    bin.install "rune"
  end

  test do
    system "#{bin}/rune"
  end
end
