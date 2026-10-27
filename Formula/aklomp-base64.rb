class Aklomp-base64 < Formula
  desc "Fast Base64 stream encoder/decoder in C99, with SIMD acceleration"
  homepage "https://example.org/aklomp-base64"
  version "0.5.2"
  url "http://127.0.0.1:8080/brew/bottles/aklomp-base64--0.5.2.loongarch64.bottle.tar.gz"
  sha256 "9ac84ebdb1820291c4f9dd0450a4c2f6c1bc99cb6c73ed59dc52dd7ff7ca3ce8"

  def install
    bin.install "aklomp-base64"
  end

  test do
    system "#{bin}/aklomp-base64"
  end
end
