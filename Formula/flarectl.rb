class Flarectl < Formula
  desc "CLI application for interacting with a Cloudflare account"
  homepage "https://example.org/flarectl"
  version "7.13.1"
  url "http://127.0.0.1:8080/brew/bottles/flarectl--7.13.1.loongarch64.bottle.tar.gz"
  sha256 "3f9071e925f7b2ffb3614ad8c9e4aaa26f9e6ce9ee2ee99369bc0090da284e26"

  def install
    bin.install "flarectl"
  end

  test do
    system "#{bin}/flarectl"
  end
end
