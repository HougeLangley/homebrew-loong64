class Fend < Formula
  desc "Arbitrary-precision unit-aware calculator"
  homepage "https://example.org/fend"
  version "1.5.9"
  url "http://127.0.0.1:8080/brew/bottles/fend--1.5.9.loongarch64.bottle.tar.gz"
  sha256 "ee11a0b0c29b32e2c0b64094161ef708b93a0ca21df7369a974716e2e7fae4e7"

  def install
    bin.install "fend"
  end

  test do
    system "#{bin}/fend"
  end
end
