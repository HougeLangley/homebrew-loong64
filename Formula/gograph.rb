class Gograph < Formula
  desc "Local-only Go static analysis engine with a built-in MCP server. Gives AI coding agents de"
  homepage "https://example.org/gograph"
  version "1.7.14"
  url "http://127.0.0.1:8080/brew/bottles/gograph--1.7.14.loongarch64.bottle.tar.gz"
  sha256 "799dc03ecc857dbd5214bbcd48f80f1d01f756a6a62e270c01d7a2696f74102a"

  def install
    bin.install "gograph"
  end

  test do
    system "#{bin}/gograph"
  end
end
