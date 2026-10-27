class Argocd < Formula
  desc "GitOps Continuous Delivery for Kubernetes"
  homepage "https://example.org/argocd"
  version "3.5.6"
  url "http://127.0.0.1:8080/brew/bottles/argocd--3.5.6.loongarch64.bottle.tar.gz"
  sha256 "78107b8030920f1ae371ef0d4d666bf730fc9cf05a2a1a02a8b103a27dfc677c"

  def install
    bin.install "argocd"
  end

  test do
    system "#{bin}/argocd"
  end
end
