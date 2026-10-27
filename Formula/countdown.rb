class Countdown < Formula
  desc "Terminal countdown timer"
  homepage "https://example.org/countdown"
  version "1.5.0"
  url "http://127.0.0.1:8080/brew/bottles/countdown--1.5.0.loongarch64.bottle.tar.gz"
  sha256 "620d3c3e61494fd56834bce5ab4652cdee6ea850028c1535210d33f79ef3b6d3"

  def install
    bin.install "countdown"
  end

  test do
    system "#{bin}/countdown"
  end
end
