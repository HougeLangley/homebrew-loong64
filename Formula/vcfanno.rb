class Vcfanno < Formula
  desc "Annotate a VCF with other VCFs/BEDs/tabixed files"
  homepage "https://example.org/vcfanno"
  version "0.3.9"
  url "http://127.0.0.1:8080/brew/bottles/vcfanno--0.3.9.loongarch64.bottle.tar.gz"
  sha256 "625db01f4fe34bee31804e8f01797529fcdd5157e7dae2d148606aee5bb2cb9c"

  def install
    bin.install "vcfanno"
  end

  test do
    system "#{bin}/vcfanno"
  end
end
