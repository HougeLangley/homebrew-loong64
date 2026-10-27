class Ongrid < Formula
  desc "An ops AI Agent that understands your infrastructure, finds the root cause, and fixes it —"
  homepage "https://example.org/ongrid"
  version "0.18.2"
  url "http://127.0.0.1:8080/brew/bottles/ongrid--0.18.2.loongarch64.bottle.tar.gz"
  sha256 "e9f8eb5013aa73256c932d96ad26c9b1b9e9a6cfa628682921ebfaf3b7572403"

  def install
    bin.install "ongrid"
  end

  test do
    system "#{bin}/ongrid"
  end
end
