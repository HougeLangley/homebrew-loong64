class Pumba < Formula
  desc "Chaos testing, network emulation, and stress testing tool for containers"
  homepage "https://example.org/pumba"
  version "1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/pumba--1.2.1.loongarch64.bottle.tar.gz"
  sha256 "c8ac6f239d43d6cc5f69cfa28ab66ea998a9d88cf9879f30fc9817d8134e3064"

  def install
    bin.install "pumba"
  end

  test do
    system "#{bin}/pumba"
  end
end
