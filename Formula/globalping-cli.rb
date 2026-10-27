class Globalping-cli < Formula
  desc "A simple CLI tool to run networking commands remotely from hundreds of globally distribute"
  homepage "https://example.org/globalping-cli"
  version "1.6.1"
  url "http://127.0.0.1:8080/brew/bottles/globalping-cli--1.6.1.loongarch64.bottle.tar.gz"
  sha256 "996e15fb4fab731174df1471d8882b31aa0ebf038c3f0bb9e47a9c8b11efe7b2"

  def install
    bin.install "globalping-cli"
  end

  test do
    system "#{bin}/globalping-cli"
  end
end
