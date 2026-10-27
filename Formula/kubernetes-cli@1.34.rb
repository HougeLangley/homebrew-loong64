class Kubernetes-cli@1.34 < Formula
  desc "Kubernetes command-line interface"
  homepage "https://example.org/kubernetes-cli@1.34"
  version "1.37.1"
  url "http://127.0.0.1:8080/brew/bottles/kubernetes-cli@1.34--1.37.1.loongarch64.bottle.tar.gz"
  sha256 "a81d961d196c34bbecc696f10e26197cb9ea7ab9c4ca8726789a412c173c7018"

  def install
    bin.install "kubernetes-cli@1.34"
  end

  test do
    system "#{bin}/kubernetes-cli@1.34"
  end
end
