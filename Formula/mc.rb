class Mc < Formula
  desc "Midnight Commander visual file manager"
  homepage "https://example.org/mc"
  version "4.8.33"
  url "http://127.0.0.1:8080/brew/bottles/mc--4.8.33.loongarch64.bottle.tar.gz"
  sha256 "203d7ca66c4bb66524408cd8da1c6389281cee326167389f9e1a317b0aadc9cd"

  def install
    bin.install "mc"
  end

  test do
    system "#{bin}/mc"
  end
end
