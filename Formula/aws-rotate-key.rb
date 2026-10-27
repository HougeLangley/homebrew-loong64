class Aws-rotate-key < Formula
  desc "Easily rotate your AWS access key"
  homepage "https://example.org/aws-rotate-key"
  version "1.2.0"
  url "http://127.0.0.1:8080/brew/bottles/aws-rotate-key--1.2.0.loongarch64.bottle.tar.gz"
  sha256 "2efc6c688bddd784ca0cf870177379608c3aef29fb5e18d4daa895934189b978"

  def install
    bin.install "aws-rotate-key"
  end

  test do
    system "#{bin}/aws-rotate-key"
  end
end
