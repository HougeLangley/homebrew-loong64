class Tfsec < Formula
  desc "Tfsec is now part of Trivy"
  homepage "https://example.org/tfsec"
  version "1.28.14"
  url "http://127.0.0.1:8080/brew/bottles/tfsec--1.28.14.loongarch64.bottle.tar.gz"
  sha256 "2c0ab04049b8d278291e3feba3d74d313b523464f1cead7931bacff46fadd68e"

  def install
    bin.install "tfsec"
  end

  test do
    system "#{bin}/tfsec"
  end
end
