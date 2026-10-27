class Opts < Formula
  desc "A Go (golang) package for building frictionless command-line interfaces"
  homepage "https://example.org/opts"
  version "1.9.0"
  url "http://127.0.0.1:8080/brew/bottles/opts--1.9.0.loongarch64.bottle.tar.gz"
  sha256 "41a14679f0b3adb6762319962496a74dc0a78b4759897fb1a722da70c007cf1d"

  def install
    bin.install "opts"
  end

  test do
    system "#{bin}/opts"
  end
end
