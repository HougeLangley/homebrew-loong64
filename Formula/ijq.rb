class Ijq < Formula
  desc "Interactive jq (mirror)"
  homepage "https://example.org/ijq"
  version "1.4.2"
  url "http://127.0.0.1:8080/brew/bottles/ijq--1.4.2.loongarch64.bottle.tar.gz"
  sha256 "9622a0a7ca2cd0519a03ca1f5896a43d84c9abe87f24342cbfdf0836e0a8fd5b"

  def install
    bin.install "ijq"
  end

  test do
    system "#{bin}/ijq"
  end
end
