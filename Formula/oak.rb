class Oak < Formula
  desc "Expressive, simple, dynamic programming language"
  homepage "https://example.org/oak"
  version "0.3"
  url "http://127.0.0.1:8080/brew/bottles/oak--0.3.loongarch64.bottle.tar.gz"
  sha256 "c1afe2d9bc0f13e502973c37baeb5f7c027da70fd9626688e468743f7c471406"

  def install
    bin.install "oak"
  end

  test do
    system "#{bin}/oak"
  end
end
