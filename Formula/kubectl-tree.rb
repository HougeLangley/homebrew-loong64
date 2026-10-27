class Kubectl-tree < Formula
  desc "Kubectl plugin to browse Kubernetes object hierarchies as a tree"
  homepage "https://example.org/kubectl-tree"
  version "0.6.0"
  url "http://127.0.0.1:8080/brew/bottles/kubectl-tree--0.6.0.loongarch64.bottle.tar.gz"
  sha256 "d1a720036ff88dddf903a31ceef8fe7e3f03f7a1907098f19ca53a060c413b28"

  def install
    bin.install "kubectl-tree"
  end

  test do
    system "#{bin}/kubectl-tree"
  end
end
