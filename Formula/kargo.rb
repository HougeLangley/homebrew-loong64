class Kargo < Formula
  desc "Multi-Stage GitOps Continuous Promotion"
  homepage "https://example.org/kargo"
  version "1.12.4"
  url "http://127.0.0.1:8080/brew/bottles/kargo--1.12.4.loongarch64.bottle.tar.gz"
  sha256 "558b7b3da6a3d29432af6d162f484e652d7d14acfb7c4d9c7c7206e6e8ee7c87"

  def install
    bin.install "kargo"
  end

  test do
    system "#{bin}/kargo"
  end
end
