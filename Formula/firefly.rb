class Firefly < Formula
  desc "Create and manage the Hyperledger FireFly stack for blockchain interaction"
  homepage "https://example.org/firefly"
  version "1.5.0"
  url "http://127.0.0.1:8080/brew/bottles/firefly--1.5.0.loongarch64.bottle.tar.gz"
  sha256 "a00aae2159ffb67b0ba18873313d9a0b4608cdd465cd6a3fc59f701aae91f287"

  def install
    bin.install "firefly"
  end

  test do
    system "#{bin}/firefly"
  end
end
