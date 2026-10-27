class Kubeconform < Formula
  desc "FAST Kubernetes manifests validator, with support for Custom Resources!"
  homepage "https://example.org/kubeconform"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/kubeconform--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "6ac9b94bff62a628725cc44054470e74347fa24712fe4bb46bf780a219c4a465"

  def install
    bin.install "kubeconform"
  end

  test do
    system "#{bin}/kubeconform"
  end
end
