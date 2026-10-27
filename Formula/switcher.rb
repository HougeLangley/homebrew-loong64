class Switcher < Formula
  desc "Run SSH and HTTP(S) on the same port"
  homepage "https://example.org/switcher"
  version "1.0.1"
  url "http://127.0.0.1:8080/brew/bottles/switcher--1.0.1.loongarch64.bottle.tar.gz"
  sha256 "0ffa288635c357f81d7dd8e6324bb00501373ad490efd4aa2f33d4428d505bec"

  def install
    bin.install "switcher"
  end

  test do
    system "#{bin}/switcher"
  end
end
