class K8sgpt < Formula
  desc "Giving Kubernetes Superpowers to everyone"
  homepage "https://example.org/k8sgpt"
  version "0.4.41"
  url "http://127.0.0.1:8080/brew/bottles/k8sgpt--0.4.41.loongarch64.bottle.tar.gz"
  sha256 "0fa6c82fbba3defcf4295834d9e9a2d3ade22c948c3bae5388b31ce8abc44c93"

  def install
    bin.install "k8sgpt"
  end

  test do
    system "#{bin}/k8sgpt"
  end
end
