class Url-shortenter < Formula
  desc "A short link service system suitable for small and medium-sized community websites. suppor"
  homepage "https://example.org/url-shortenter"
  version "0.0.3"
  url "http://127.0.0.1:8080/brew/bottles/url-shortenter--0.0.3.loongarch64.bottle.tar.gz"
  sha256 "a0ce63ccadc7a9c3abcac7695c1eac6a205c69b7d4a92b0bc9f6afe87d7179a5"

  def install
    bin.install "url-shortenter"
  end

  test do
    system "#{bin}/url-shortenter"
  end
end
