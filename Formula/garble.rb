class Garble < Formula
  desc "Obfuscate Go builds"
  homepage "https://example.org/garble"
  version "0.18.0"
  url "http://127.0.0.1:8080/brew/bottles/garble--0.18.0.loongarch64.bottle.tar.gz"
  sha256 "27b0d60e7483617151bcce477e9756b5c67832437961937885f45f8129517d21"

  def install
    bin.install "garble"
  end

  test do
    system "#{bin}/garble"
  end
end
