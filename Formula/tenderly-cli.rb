class Tenderly-cli < Formula
  desc "CLI tool for Smart Contract error tracking, monitoring and alerting."
  homepage "https://example.org/tenderly-cli"
  version "1.7.1"
  url "http://127.0.0.1:8080/brew/bottles/tenderly-cli--1.7.1.loongarch64.bottle.tar.gz"
  sha256 "7565096c3c327f29d0a2f369c8adfe4b9ce8ff549ebb0a47454202f26aca5963"

  def install
    bin.install "tenderly-cli"
  end

  test do
    system "#{bin}/tenderly-cli"
  end
end
