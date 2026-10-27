class Tftp-now < Formula
  desc "Single-binary TFTP server and client that you can use right now"
  homepage "https://example.org/tftp-now"
  version "1.2.0"
  url "http://127.0.0.1:8080/brew/bottles/tftp-now--1.2.0.loongarch64.bottle.tar.gz"
  sha256 "45c3435fc1ed9bd5482d04a86ff019d58a65a2f6b175163c9cdfe88d388746b3"

  def install
    bin.install "tftp-now"
  end

  test do
    system "#{bin}/tftp-now"
  end
end
