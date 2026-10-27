class Nom < Formula
  desc "RSS reader for the terminal"
  homepage "https://example.org/nom"
  version "3.3.3"
  url "http://127.0.0.1:8080/brew/bottles/nom--3.3.3.loongarch64.bottle.tar.gz"
  sha256 "9be0e2d12c3ea3b7dde4f82fb24770c750049a2adc5c1064528b1eaee2a593d6"

  def install
    bin.install "nom"
  end

  test do
    system "#{bin}/nom"
  end
end
