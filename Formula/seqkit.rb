class Seqkit < Formula
  desc "Cross-platform and ultrafast toolkit for FASTA/Q file manipulation in Golang"
  homepage "https://example.org/seqkit"
  version "2.14.0"
  url "http://127.0.0.1:8080/brew/bottles/seqkit--2.14.0.loongarch64.bottle.tar.gz"
  sha256 "e701f087c8783816b9a6f0aa0b0050a423e68f324a322956d45e27ea548af021"

  def install
    bin.install "seqkit"
  end

  test do
    system "#{bin}/seqkit"
  end
end
