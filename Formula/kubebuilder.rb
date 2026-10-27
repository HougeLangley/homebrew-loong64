class Kubebuilder < Formula
  desc "SDK for building Kubernetes APIs using CRDs"
  homepage "https://example.org/kubebuilder"
  version "4.16.0"
  url "http://127.0.0.1:8080/brew/bottles/kubebuilder--4.16.0.loongarch64.bottle.tar.gz"
  sha256 "9a3805561e722706af8ebd03eb8569c6fb0326672b625380eef2caf73f22f12e"

  def install
    bin.install "kubebuilder"
  end

  test do
    system "#{bin}/kubebuilder"
  end
end
