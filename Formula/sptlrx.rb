class Sptlrx < Formula
  desc "Synchronized lyrics in your terminal"
  homepage "https://example.org/sptlrx"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/sptlrx--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "6558e28d069354067c8d6831fc9f6b515f0434560dd093cd09bdcfe2f53a9a12"

  def install
    bin.install "sptlrx"
  end

  test do
    system "#{bin}/sptlrx"
  end
end
