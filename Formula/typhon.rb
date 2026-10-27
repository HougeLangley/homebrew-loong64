class Typhon < Formula
  desc "A wrapper around Go's net/http to provide safety and convenience. At Monzo, Typhon forms t"
  homepage "https://example.org/typhon"
  version "1.1.10"
  url "http://127.0.0.1:8080/brew/bottles/typhon--1.1.10.loongarch64.bottle.tar.gz"
  sha256 "84dd5a3df7a05303ff83170920cd8a14a6e3d9b8d3ffe9434a4d51652d73a434"

  def install
    bin.install "typhon"
  end

  test do
    system "#{bin}/typhon"
  end
end
