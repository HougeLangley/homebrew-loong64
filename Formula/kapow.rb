class Kapow < Formula
  desc "Kapow! If you can script it, you can HTTP it."
  homepage "https://example.org/kapow"
  version "0.7.1"
  url "http://127.0.0.1:8080/brew/bottles/kapow--0.7.1.loongarch64.bottle.tar.gz"
  sha256 "e24649f03aee2cd774899ec457b464e7adfbc4ad9fcf4e9e06f0965c3c3b8732"

  def install
    bin.install "kapow"
  end

  test do
    system "#{bin}/kapow"
  end
end
