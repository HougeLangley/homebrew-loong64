class Goenv < Formula
  desc "Go version management"
  homepage "https://example.org/goenv"
  version "3.2.2"
  url "http://127.0.0.1:8080/brew/bottles/goenv--3.2.2.loongarch64.bottle.tar.gz"
  sha256 "62dc2ac8e5390f9d8c5a351e89adcabdfb89efaa4b5253f0d002ab0428e8d698"

  def install
    bin.install "goenv"
  end

  test do
    system "#{bin}/goenv"
  end
end
