class Trivy-operator < Formula
  desc "Kubernetes-native security toolkit"
  homepage "https://example.org/trivy-operator"
  version "0.35.0"
  url "http://127.0.0.1:8080/brew/bottles/trivy-operator--0.35.0.loongarch64.bottle.tar.gz"
  sha256 "c4de0721ad9ae35c42e9a49ac894fd13814b47ec983210c9373b57c944477494"

  def install
    bin.install "trivy-operator"
  end

  test do
    system "#{bin}/trivy-operator"
  end
end
