class Repeater < Formula
  desc "xargs, but different..! Better at some things (repeating stuff), worse at others (not repe"
  homepage "https://example.org/repeater"
  version "1.2.8"
  url "http://127.0.0.1:8080/brew/bottles/repeater--1.2.8.loongarch64.bottle.tar.gz"
  sha256 "096c7c243d2792d7c4d1830c003e6b40ca9170ecb9ca630ba0405841c5ccbf0e"

  def install
    bin.install "repeater"
  end

  test do
    system "#{bin}/repeater"
  end
end
