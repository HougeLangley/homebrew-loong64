class Hjson < Formula
  desc "Convert JSON to HJSON and vice versa"
  homepage "https://example.org/hjson"
  version "4.7.1"
  url "http://127.0.0.1:8080/brew/bottles/hjson--4.7.1.loongarch64.bottle.tar.gz"
  sha256 "1912b44c24126fc9fea3d7dde61384a97e412f17814f302333a00276669f3dcf"

  def install
    bin.install "hjson"
  end

  test do
    system "#{bin}/hjson"
  end
end
