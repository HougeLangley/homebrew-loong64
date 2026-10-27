class Fileb0x < Formula
  desc "a better customizable tool to embed files in go; also update embedded files remotely witho"
  homepage "https://example.org/fileb0x"
  version "1.1.4"
  url "http://127.0.0.1:8080/brew/bottles/fileb0x--1.1.4.loongarch64.bottle.tar.gz"
  sha256 "589452853f5b2fa483d55342b27dd1e718251764658e582be5fff88dd6bb72eb"

  def install
    bin.install "fileb0x"
  end

  test do
    system "#{bin}/fileb0x"
  end
end
