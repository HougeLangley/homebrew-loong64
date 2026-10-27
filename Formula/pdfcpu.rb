class Pdfcpu < Formula
  desc "PDF tooling for Go and the command line."
  homepage "https://example.org/pdfcpu"
  version "0.16.3"
  url "http://127.0.0.1:8080/brew/bottles/pdfcpu--0.16.3.loongarch64.bottle.tar.gz"
  sha256 "53be2342ea5031ad388f6011fb6a8e77a49e64198a74b022d69a6fb829e22f1d"

  def install
    bin.install "pdfcpu"
  end

  test do
    system "#{bin}/pdfcpu"
  end
end
