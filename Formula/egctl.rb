class Egctl < Formula
  desc "Command-line utility for operating Envoy Gateway"
  homepage "https://example.org/egctl"
  version "1.9.3"
  url "http://127.0.0.1:8080/brew/bottles/egctl--1.9.3.loongarch64.bottle.tar.gz"
  sha256 "f6343683122966ffda59e6a32eddb648f8c882211194d41f18dbb721c5d3a7a8"

  def install
    bin.install "egctl"
  end

  test do
    system "#{bin}/egctl"
  end
end
