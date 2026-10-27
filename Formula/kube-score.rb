class Kube-score < Formula
  desc "Kubernetes object analysis with recommendations for improved reliability and security. kub"
  homepage "https://example.org/kube-score"
  version "1.20.0"
  url "http://127.0.0.1:8080/brew/bottles/kube-score--1.20.0.loongarch64.bottle.tar.gz"
  sha256 "f709cec5f904a5894b2b07c7c7802546479d6095b1d714a7633c39c13a5c6884"

  def install
    bin.install "kube-score"
  end

  test do
    system "#{bin}/kube-score"
  end
end
