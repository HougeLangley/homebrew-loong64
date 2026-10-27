class Doppler < Formula
  desc "CLI for interacting with Doppler secrets and configuration"
  homepage "https://example.org/doppler"
  version "3.77.1"
  url "http://127.0.0.1:8080/brew/bottles/doppler--3.77.1.loongarch64.bottle.tar.gz"
  sha256 "d7f99d0092ada6c64998c912cadb249f58f7d2e2d80af2539100a3fda91a260b"

  def install
    bin.install "doppler"
  end

  test do
    system "#{bin}/doppler"
  end
end
