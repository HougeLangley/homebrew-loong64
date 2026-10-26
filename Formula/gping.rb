class Gping < Formula
  desc "Ping with a graph"
  homepage "https://example.org/gping"
  version "1.21.0"
  url "http://127.0.0.1:8080/brew/bottles/gping--1.21.0.loongarch64.bottle.tar.gz"
  sha256 "20659ffc1a2f2e3d26f650f3d10fd9bb1d4ec2253905d50927c994a64739b264"

  def install
    bin.install "gping"
  end

  test do
    system "#{bin}/gping"
  end
end
