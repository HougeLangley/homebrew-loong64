class Fileb0x < Formula
  desc "a better customizable tool to embed files in go; also update embedded files remotely witho"
  homepage "https://example.org/fileb0x"
  version "1.1.4"
  url "http://127.0.0.1:8080/brew/bottles/fileb0x--1.1.4.loongarch64.bottle.tar.gz"
  sha256 "bb46227dff1e7b4167d1601130f95a077661241e60ff41f3bb65925a49e5d22b"

  def install
    bin.install "fileb0x"
  end

  test do
    system "#{bin}/fileb0x"
  end
end
