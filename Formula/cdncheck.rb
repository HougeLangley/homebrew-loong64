class Cdncheck < Formula
  desc "Utility to detect various technology for a given IP address"
  homepage "https://example.org/cdncheck"
  version "1.3.3"
  url "http://127.0.0.1:8080/brew/bottles/cdncheck--1.3.3.loongarch64.bottle.tar.gz"
  sha256 "b916d0dce5cc3a4ae0c029e4cff629a9a798780139089ff33a52b2682a568f1b"

  def install
    bin.install "cdncheck"
  end

  test do
    system "#{bin}/cdncheck"
  end
end
