class Kompose < Formula
  desc "Convert Compose to Kubernetes"
  homepage "https://example.org/kompose"
  version "1.38.0"
  url "http://127.0.0.1:8080/brew/bottles/kompose--1.38.0.loongarch64.bottle.tar.gz"
  sha256 "e08d7d53cbb8aaaf96e591cac63cd0b0422568a9a59292d2981eab8f3477f285"

  def install
    bin.install "kompose"
  end

  test do
    system "#{bin}/kompose"
  end
end
