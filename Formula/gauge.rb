class Gauge < Formula
  desc "Test automation tool that supports executable documentation"
  homepage "https://example.org/gauge"
  version "1.6.41"
  url "http://127.0.0.1:8080/brew/bottles/gauge--1.6.41.loongarch64.bottle.tar.gz"
  sha256 "b454c20749c7173ee5abc8bbc5d2fb35234bca4a67cc712a460b8f410de32150"

  def install
    bin.install "gauge"
  end

  test do
    system "#{bin}/gauge"
  end
end
