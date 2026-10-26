class Dysk < Formula
  desc "A linux 'df' alternative with a better view"
  homepage "https://example.org/dysk"
  version "3.8.1"
  url "http://127.0.0.1:8080/brew/bottles/dysk--3.8.1.loongarch64.bottle.tar.gz"
  sha256 "12f37c07382da202b12ff02ccd5d2af32b036d17c2cdfb3f783c6de50289e0ea"

  def install
    bin.install "dysk"
  end

  test do
    system "#{bin}/dysk"
  end
end
