class Plakar < Formula
  desc "Create backups with compression, encryption and deduplication"
  homepage "https://example.org/plakar"
  version "1.1.8"
  url "http://127.0.0.1:8080/brew/bottles/plakar--1.1.8.loongarch64.bottle.tar.gz"
  sha256 "8f9d74800205a56a1f011fdfb9b7826c42cd0d56f5f9295b21004b75407084bf"

  def install
    bin.install "plakar"
  end

  test do
    system "#{bin}/plakar"
  end
end
