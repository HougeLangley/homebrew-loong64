class Kubevirt < Formula
  desc "Kubernetes Virtualization API and runtime in order to define and manage virtual machines."
  homepage "https://example.org/kubevirt"
  version "1.9.1"
  url "http://127.0.0.1:8080/brew/bottles/kubevirt--1.9.1.loongarch64.bottle.tar.gz"
  sha256 "38f326b2d7c73c6426a33379802a9be35bc41fa88bca13ecd641baeb0e1d9a19"

  def install
    bin.install "kubevirt"
  end

  test do
    system "#{bin}/kubevirt"
  end
end
