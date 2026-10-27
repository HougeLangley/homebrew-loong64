class Terrapin-scanner < Formula
  desc "Vulnerability scanner for the Terrapin attack"
  homepage "https://example.org/terrapin-scanner"
  version "1.1.3"
  url "http://127.0.0.1:8080/brew/bottles/terrapin-scanner--1.1.3.loongarch64.bottle.tar.gz"
  sha256 "4367aeaa6807258c9ef2dbbad349e2836afc45b15426c38147777ad51dec967b"

  def install
    bin.install "terrapin-scanner"
  end

  test do
    system "#{bin}/terrapin-scanner"
  end
end
