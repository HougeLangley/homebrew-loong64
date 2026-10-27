class Opsy < Formula
  desc "Opsy - Your AI-Powered SRE Colleague"
  homepage "https://example.org/opsy"
  version "0.0.3"
  url "http://127.0.0.1:8080/brew/bottles/opsy--0.0.3.loongarch64.bottle.tar.gz"
  sha256 "ebe1711ef75ccea9aea44308d57dbf4791457bf9ceae9664c29a574d14c2267e"

  def install
    bin.install "opsy"
  end

  test do
    system "#{bin}/opsy"
  end
end
