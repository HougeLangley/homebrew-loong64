class Chainloop-cli < Formula
  desc "CLI for interacting with Chainloop"
  homepage "https://example.org/chainloop-cli"
  version "1.128.0"
  url "http://127.0.0.1:8080/brew/bottles/chainloop-cli--1.128.0.loongarch64.bottle.tar.gz"
  sha256 "dcd0b24b1c9af2124a23934c535034dfa2ce1609ba1855efc7b404e26995f8f8"

  def install
    bin.install "chainloop-cli"
  end

  test do
    system "#{bin}/chainloop-cli"
  end
end
