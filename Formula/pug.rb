class Pug < Formula
  desc "Drive terraform at terminal velocity"
  homepage "https://example.org/pug"
  version "0.6.5"
  url "http://127.0.0.1:8080/brew/bottles/pug--0.6.5.loongarch64.bottle.tar.gz"
  sha256 "0b02cb05d872265c4c5967775f22340010955537e0a5c3f2a79ea47d54398db1"

  def install
    bin.install "pug"
  end

  test do
    system "#{bin}/pug"
  end
end
