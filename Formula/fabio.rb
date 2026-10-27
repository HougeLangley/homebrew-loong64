class Fabio < Formula
  desc "Consul Load-Balancing made simple"
  homepage "https://example.org/fabio"
  version "1.8.0"
  url "http://127.0.0.1:8080/brew/bottles/fabio--1.8.0.loongarch64.bottle.tar.gz"
  sha256 "6445d8c71630b59da76cd8f1bad3fdd874f8adb4af50fd417e3abf58b1e7f953"

  def install
    bin.install "fabio"
  end

  test do
    system "#{bin}/fabio"
  end
end
