class Opa < Formula
  desc "Open source, general-purpose policy engine"
  homepage "https://example.org/opa"
  version "1.21.4"
  url "http://127.0.0.1:8080/brew/bottles/opa--1.21.4.loongarch64.bottle.tar.gz"
  sha256 "3c0336bbe7935fdda881096b0a93d60342dc2a3c0f4623f77f0d69480ed1c58c"

  def install
    bin.install "opa"
  end

  test do
    system "#{bin}/opa"
  end
end
