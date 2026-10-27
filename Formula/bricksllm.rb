class Bricksllm < Formula
  desc "🔒 Enterprise-grade API gateway that helps you monitor and impose cost or rate limits per A"
  homepage "https://example.org/bricksllm"
  version "1.45.2"
  url "http://127.0.0.1:8080/brew/bottles/bricksllm--1.45.2.loongarch64.bottle.tar.gz"
  sha256 "6685e78a4c3f9ef3b43aab17f0b5fd9a03c0aed3deefae2d2ca0ffd70c705fe9"

  def install
    bin.install "bricksllm"
  end

  test do
    system "#{bin}/bricksllm"
  end
end
