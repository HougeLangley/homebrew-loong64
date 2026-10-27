class Gci < Formula
  desc "Control Golang package import order and make it always deterministic"
  homepage "https://example.org/gci"
  version "0.14.0"
  url "http://127.0.0.1:8080/brew/bottles/gci--0.14.0.loongarch64.bottle.tar.gz"
  sha256 "8b6960a66f2421381992689c392afe3e3ed4a7eb02cc091b12b8b2a8b6dbce65"

  def install
    bin.install "gci"
  end

  test do
    system "#{bin}/gci"
  end
end
