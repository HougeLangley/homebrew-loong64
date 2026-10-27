class Argocd-autopilot < Formula
  desc "Opinionated way of installing Argo CD and managing GitOps repositories"
  homepage "https://example.org/argocd-autopilot"
  version "0.4.20"
  url "http://127.0.0.1:8080/brew/bottles/argocd-autopilot--0.4.20.loongarch64.bottle.tar.gz"
  sha256 "d535e83918976c76ff177498a71c048677df278d1e24a360b3592347b348e30f"

  def install
    bin.install "argocd-autopilot"
  end

  test do
    system "#{bin}/argocd-autopilot"
  end
end
