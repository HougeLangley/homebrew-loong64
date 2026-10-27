class Errcheck < Formula
  desc "Finds silently ignored errors in Go code"
  homepage "https://example.org/errcheck"
  version "1.30.0"
  url "http://127.0.0.1:8080/brew/bottles/errcheck--1.30.0.loongarch64.bottle.tar.gz"
  sha256 "9c51fd6cb32378cc4959364bf72e6296d8edfc4516363848d2c17b6559f8029d"

  def install
    bin.install "errcheck"
  end

  test do
    system "#{bin}/errcheck"
  end
end
