class Errcheck < Formula
  desc "Finds silently ignored errors in Go code"
  homepage "https://example.org/errcheck"
  version "1.30.0"
  url "http://127.0.0.1:8080/brew/bottles/errcheck--1.30.0.loongarch64.bottle.tar.gz"
  sha256 "ccdb81d35c8070c890dcd4444836beed888b322da1d9aa7602f53daac9b3b8bb"

  def install
    bin.install "errcheck"
  end

  test do
    system "#{bin}/errcheck"
  end
end
