class Redress < Formula
  desc "Tool for analyzing stripped Go binaries compiled with the Go compiler"
  homepage "https://example.org/redress"
  version "1.2.98"
  url "http://127.0.0.1:8080/brew/bottles/redress--1.2.98.loongarch64.bottle.tar.gz"
  sha256 "47dacd074c1d313b24906bd5a8c44e142d7cc792ddaa8ad6c989043a01b29a78"

  def install
    bin.install "redress"
  end

  test do
    system "#{bin}/redress"
  end
end
