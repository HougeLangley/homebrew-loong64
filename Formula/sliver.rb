class Sliver < Formula
  desc "Adversary Emulation Framework"
  homepage "https://example.org/sliver"
  version "1.7.9"
  url "http://127.0.0.1:8080/brew/bottles/sliver--1.7.9.loongarch64.bottle.tar.gz"
  sha256 "cdc0c4018c75801650954750d39c7809e5087b3937aedc71b26c0212d557ea9b"

  def install
    bin.install "sliver"
  end

  test do
    system "#{bin}/sliver"
  end
end
