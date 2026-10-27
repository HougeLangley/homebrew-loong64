class Reckoner < Formula
  desc "Declaratively install and manage multiple Helm chart releases"
  homepage "https://example.org/reckoner"
  version "6.3.0"
  url "http://127.0.0.1:8080/brew/bottles/reckoner--6.3.0.loongarch64.bottle.tar.gz"
  sha256 "61e043fea55168037894b0801fb33a036803f137bd2c4c16745987bb518f7207"

  def install
    bin.install "reckoner"
  end

  test do
    system "#{bin}/reckoner"
  end
end
