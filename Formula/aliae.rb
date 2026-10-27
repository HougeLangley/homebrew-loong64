class Aliae < Formula
  desc "Cross shell and platform alias management"
  homepage "https://example.org/aliae"
  version "1.6.0"
  url "http://127.0.0.1:8080/brew/bottles/aliae--1.6.0.loongarch64.bottle.tar.gz"
  sha256 "e81bc86db71b8aae935d7c77d88676da92204fbb8d2a293004934588bd45ecf1"

  def install
    bin.install "aliae"
  end

  test do
    system "#{bin}/aliae"
  end
end
