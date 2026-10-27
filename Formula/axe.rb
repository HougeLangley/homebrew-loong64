class Axe < Formula
  desc "A lightweight cli for running single-purpose AI agents. Define focused agents in TOML, tri"
  homepage "https://example.org/axe"
  version "1.11.0"
  url "http://127.0.0.1:8080/brew/bottles/axe--1.11.0.loongarch64.bottle.tar.gz"
  sha256 "fc87d244fcb5e21d4ef8b99a03b2860edb1e35dd10fa986c37ced8bbe3b39385"

  def install
    bin.install "axe"
  end

  test do
    system "#{bin}/axe"
  end
end
