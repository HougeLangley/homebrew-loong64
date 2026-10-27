class Buf < Formula
  desc "New way of working with Protocol Buffers"
  homepage "https://example.org/buf"
  version "1.75.0"
  url "http://127.0.0.1:8080/brew/bottles/buf--1.75.0.loongarch64.bottle.tar.gz"
  sha256 "f23d2e135d8fb7aeffcfe5786b477767043a9ec9f8f6853c95dad56142eb2353"

  def install
    bin.install "buf"
  end

  test do
    system "#{bin}/buf"
  end
end
