class Sift < Formula
  desc "Fast and powerful open source alternative to grep"
  homepage "https://example.org/sift"
  version "0.9.2"
  url "http://127.0.0.1:8080/brew/bottles/sift--0.9.2.loongarch64.bottle.tar.gz"
  sha256 "4d898b25740d247638fa4fdd6008e8650f839a5ce01b4b01d9719a705bcb8bd0"

  def install
    bin.install "sift"
  end

  test do
    system "#{bin}/sift"
  end
end
