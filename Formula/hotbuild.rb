class Hotbuild < Formula
  desc "Cross platform hot compilation tool for go"
  homepage "https://example.org/hotbuild"
  version "1.0.9"
  url "http://127.0.0.1:8080/brew/bottles/hotbuild--1.0.9.loongarch64.bottle.tar.gz"
  sha256 "f17f13d02d094f39a9cf0bf8edd698a3d62d87575a8bee8a42298d75489b6884"

  def install
    bin.install "hotbuild"
  end

  test do
    system "#{bin}/hotbuild"
  end
end
