class Titus < Formula
  desc "High-performance secrets scanner"
  homepage "https://example.org/titus"
  version "1.2.11"
  url "http://127.0.0.1:8080/brew/bottles/titus--1.2.11.loongarch64.bottle.tar.gz"
  sha256 "b4af948ad89c4820d59f72b5d7750b8cb7196c90696480d17847a234adf7fc48"

  def install
    bin.install "titus"
  end

  test do
    system "#{bin}/titus"
  end
end
