class Runc < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://example.org/runc"
  version "1.5.2"
  url "http://127.0.0.1:8080/brew/bottles/runc--1.5.2.loongarch64.bottle.tar.gz"
  sha256 "6db277426f20f7340d6b37d238839d0e7f109f32f5d5170281b8b8f8bcd405d1"

  def install
    bin.install "runc"
  end

  test do
    system "#{bin}/runc"
  end
end
