class Tygo < Formula
  desc "Generate Typescript types from Golang source code"
  homepage "https://example.org/tygo"
  version "0.2.21"
  url "http://127.0.0.1:8080/brew/bottles/tygo--0.2.21.loongarch64.bottle.tar.gz"
  sha256 "85596d9fa3238e34911e63add42e1adb51de5b330b7e0145eea35f681be79882"

  def install
    bin.install "tygo"
  end

  test do
    system "#{bin}/tygo"
  end
end
