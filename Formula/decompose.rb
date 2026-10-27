class Decompose < Formula
  desc "Reverse-engineering tool for docker environments"
  homepage "https://example.org/decompose"
  version "1.11.8"
  url "http://127.0.0.1:8080/brew/bottles/decompose--1.11.8.loongarch64.bottle.tar.gz"
  sha256 "c96a55a931fd8d3a9be4164942c1783f2821a00986f245808a308a1f9678dd06"

  def install
    bin.install "decompose"
  end

  test do
    system "#{bin}/decompose"
  end
end
