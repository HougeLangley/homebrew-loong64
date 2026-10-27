class Shush < Formula
  desc "Encrypt and decrypt secrets using the AWS Key Management Service"
  homepage "https://example.org/shush"
  version "1.5.5"
  url "http://127.0.0.1:8080/brew/bottles/shush--1.5.5.loongarch64.bottle.tar.gz"
  sha256 "37a66e0d5b54e67331e74cb515d46919ceb1caaf9e2ce5dc38258f9b233a4062"

  def install
    bin.install "shush"
  end

  test do
    system "#{bin}/shush"
  end
end
