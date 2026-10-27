class Tanka < Formula
  desc "Flexible, reusable and concise configuration for Kubernetes using Jsonnet"
  homepage "https://example.org/tanka"
  version "0.40.0"
  url "http://127.0.0.1:8080/brew/bottles/tanka--0.40.0.loongarch64.bottle.tar.gz"
  sha256 "6f67e75c99d1883f0b6311b22ca01965c58b82c3ffbec657d9e8509f855b2cb5"

  def install
    bin.install "tanka"
  end

  test do
    system "#{bin}/tanka"
  end
end
