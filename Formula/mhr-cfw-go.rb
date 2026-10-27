class Mhr-cfw-go < Formula
  desc "A local proxy that runs on your machine and forwards traffic through Google."
  homepage "https://example.org/mhr-cfw-go"
  version "1.4.0"
  url "http://127.0.0.1:8080/brew/bottles/mhr-cfw-go--1.4.0.loongarch64.bottle.tar.gz"
  sha256 "15bdc4eac1bfb650766942b4e44ce4e4f62998f5bc6ecf80daaac1af3fafef17"

  def install
    bin.install "mhr-cfw-go"
  end

  test do
    system "#{bin}/mhr-cfw-go"
  end
end
