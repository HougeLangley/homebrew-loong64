class Daylight < Formula
  desc "a command-line program for tracking sunrise and sunset times"
  homepage "https://example.org/daylight"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/daylight--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "6c3ddcabc55c6324aae2936c13bf436b0e7dfe3cdbdb769fc093b886aea6b046"

  def install
    bin.install "daylight"
  end

  test do
    system "#{bin}/daylight"
  end
end
