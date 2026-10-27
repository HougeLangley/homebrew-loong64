class Terrapin-scanner < Formula
  desc "Vulnerability scanner for the Terrapin attack"
  homepage "https://example.org/terrapin-scanner"
  version "1.1.3"
  url "http://127.0.0.1:8080/brew/bottles/terrapin-scanner--1.1.3.loongarch64.bottle.tar.gz"
  sha256 "19b04e9f655fddef42b982f94af551e81add239ff820150bcb040ecc33e588b1"

  def install
    bin.install "terrapin-scanner"
  end

  test do
    system "#{bin}/terrapin-scanner"
  end
end
