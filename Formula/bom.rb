class Bom < Formula
  desc "Utility to generate SPDX-compliant Bill of Materials manifests"
  homepage "https://example.org/bom"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/bom--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "bb6e71f17cc9f033d6af4a785ace45b2b783f452d0f8b1a864caccbd54bdda43"

  def install
    bin.install "bom"
  end

  test do
    system "#{bin}/bom"
  end
end
