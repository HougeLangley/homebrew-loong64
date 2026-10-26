class Httpstat < Formula
  desc "Curl statistics visualizer"
  homepage "https://example.org/httpstat"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/httpstat--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "b1305f63cf3a28908a9b267cf9a5899c6adfb0b7573d22619cc9bb5f0ce9c7fc"

  def install
    bin.install "httpstat"
  end

  test do
    system "#{bin}/httpstat"
  end
end
