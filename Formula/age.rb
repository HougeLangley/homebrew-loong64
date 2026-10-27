class Age < Formula
  desc "Simple, modern, secure file encryption"
  homepage "https://example.org/age"
  version "1.3.2"
  url "http://127.0.0.1:8080/brew/bottles/age--1.3.2.loongarch64.bottle.tar.gz"
  sha256 "75ee1bd16b3ce5855281bbf028d5eed16a2c5605f957ee2ff2b4cf86afbc3185"

  def install
    bin.install "age"
  end

  test do
    system "#{bin}/age"
  end
end
