class Fq < Formula
  desc "fq - jq for binary formats. Tool, language and decoders for working with binary formats."
  homepage "https://example.org/fq"
  version "0.18.0"
  url "http://127.0.0.1:8080/brew/bottles/fq--0.18.0.loongarch64.bottle.tar.gz"
  sha256 "e768843b6bd99cd56d7d32ab545f1a0e89c31392ccd41b83fac23408bd675ff3"

  def install
    bin.install "fq"
  end

  test do
    system "#{bin}/fq"
  end
end
