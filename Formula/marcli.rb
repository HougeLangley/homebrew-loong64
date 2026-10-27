class Marcli < Formula
  desc "Parse MARC (ISO 2709) files"
  homepage "https://example.org/marcli"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/marcli--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "cc0e1cdc0090c402a16b94cd60bc3c8261a71c849d5564c2fee08d5fd4588103"

  def install
    bin.install "marcli"
  end

  test do
    system "#{bin}/marcli"
  end
end
