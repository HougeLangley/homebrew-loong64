class Interactsh < Formula
  desc "An OOB interaction gathering server and client library"
  homepage "https://example.org/interactsh"
  version "1.4.1"
  url "http://127.0.0.1:8080/brew/bottles/interactsh--1.4.1.loongarch64.bottle.tar.gz"
  sha256 "243b306706564707343e07243b1d9c0b1fa387847acb346b03df67c462f36583"

  def install
    bin.install "interactsh"
  end

  test do
    system "#{bin}/interactsh"
  end
end
