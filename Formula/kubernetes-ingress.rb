class Kubernetes-ingress < Formula
  desc "NGINX and  NGINX Plus Ingress Controllers for Kubernetes"
  homepage "https://example.org/kubernetes-ingress"
  version "5.7.0"
  url "http://127.0.0.1:8080/brew/bottles/kubernetes-ingress--5.7.0.loongarch64.bottle.tar.gz"
  sha256 "2f315354422cbd4b03d03bdc434582d1124cc9bf5629a3f5aa1f85f1e3d8ae5e"

  def install
    bin.install "kubernetes-ingress"
  end

  test do
    system "#{bin}/kubernetes-ingress"
  end
end
