class Dojo < Formula
  desc "Containerize your development and operations environment"
  homepage "https://example.org/dojo"
  version "0.13.3"
  url "http://127.0.0.1:8080/brew/bottles/dojo--0.13.3.loongarch64.bottle.tar.gz"
  sha256 "e892eabff5bda8990ad021e58a08fd10cb97f6f5fccae2a38a069444fbbd375f"

  def install
    bin.install "dojo"
  end

  test do
    system "#{bin}/dojo"
  end
end
