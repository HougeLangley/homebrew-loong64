class Cc-connect < Formula
  desc "Bridges local AI coding agents to messaging platforms"
  homepage "https://example.org/cc-connect"
  version "1.5.0"
  url "http://127.0.0.1:8080/brew/bottles/cc-connect--1.5.0.loongarch64.bottle.tar.gz"
  sha256 "fe4c9ad26b286eab2a772e16e86b733fadd774e9a2d531e6990987671d625585"

  def install
    bin.install "cc-connect"
  end

  test do
    system "#{bin}/cc-connect"
  end
end
