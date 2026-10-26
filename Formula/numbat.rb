class Numbat < Formula
  desc "Units-aware scientific calculator"
  homepage "https://example.org/numbat"
  version "1.24.0"
  url "http://127.0.0.1:8080/brew/bottles/numbat--1.24.0.loongarch64.bottle.tar.gz"
  sha256 "117b65d3399aa65dcd5f0fa804e864b06b21cf6ea0258c732bb149aa228dc5f9"

  def install
    bin.install "numbat"
  end

  test do
    system "#{bin}/numbat"
  end
end
