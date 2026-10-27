class Coolify-cli < Formula
  desc "CLI for Coolify"
  homepage "https://example.org/coolify-cli"
  version "1.11.0"
  url "http://127.0.0.1:8080/brew/bottles/coolify-cli--1.11.0.loongarch64.bottle.tar.gz"
  sha256 "04b8307b9e7efb29d191a91c24bd056d1c5eb6e6d1b805da04e93e9f62925ac4"

  def install
    bin.install "coolify-cli"
  end

  test do
    system "#{bin}/coolify-cli"
  end
end
