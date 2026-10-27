class Evans < Formula
  desc "Evans: more expressive universal gRPC client"
  homepage "https://example.org/evans"
  version "0.10.11"
  url "http://127.0.0.1:8080/brew/bottles/evans--0.10.11.loongarch64.bottle.tar.gz"
  sha256 "9b2d1907d605a2aa347434e9e612d75f1ef3a449ec9bdb0cb1e4811455aded14"

  def install
    bin.install "evans"
  end

  test do
    system "#{bin}/evans"
  end
end
