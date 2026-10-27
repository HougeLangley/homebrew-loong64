class Aws-console < Formula
  desc "Command-line to use AWS CLI credentials to launch the AWS console in a browser"
  homepage "https://example.org/aws-console"
  version "1.24.4"
  url "http://127.0.0.1:8080/brew/bottles/aws-console--1.24.4.loongarch64.bottle.tar.gz"
  sha256 "0a67ec77d1e69a0a702a4f9e6eaf2d874527ada192a13cc55928c43f9d14c188"

  def install
    bin.install "aws-console"
  end

  test do
    system "#{bin}/aws-console"
  end
end
