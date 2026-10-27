class Kyverno < Formula
  desc "Unified Policy as Code"
  homepage "https://example.org/kyverno"
  version "1.19.2"
  url "http://127.0.0.1:8080/brew/bottles/kyverno--1.19.2.loongarch64.bottle.tar.gz"
  sha256 "5d722114d614b8de3bb81876153ba8ef8f65a5ed2e53add649aa03839dd8db85"

  def install
    bin.install "kyverno"
  end

  test do
    system "#{bin}/kyverno"
  end
end
