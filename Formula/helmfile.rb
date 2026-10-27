class Helmfile < Formula
  desc "Declaratively deploy your Kubernetes manifests, Kustomize configs, and Charts as Helm rele"
  homepage "https://example.org/helmfile"
  version "1.8.2"
  url "http://127.0.0.1:8080/brew/bottles/helmfile--1.8.2.loongarch64.bottle.tar.gz"
  sha256 "fe53191c69866a745dfa0a1b8ec9c040f3f50d6beb462e41a75dfc963b9ea2a2"

  def install
    bin.install "helmfile"
  end

  test do
    system "#{bin}/helmfile"
  end
end
