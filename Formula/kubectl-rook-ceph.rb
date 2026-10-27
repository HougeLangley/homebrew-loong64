class Kubectl-rook-ceph < Formula
  desc "Rook plugin for Ceph management"
  homepage "https://example.org/kubectl-rook-ceph"
  version "0.9.6"
  url "http://127.0.0.1:8080/brew/bottles/kubectl-rook-ceph--0.9.6.loongarch64.bottle.tar.gz"
  sha256 "daacdde5b2ed4c093578a43a0923a09f34d71541f8f65e654a4074e989c8914e"

  def install
    bin.install "kubectl-rook-ceph"
  end

  test do
    system "#{bin}/kubectl-rook-ceph"
  end
end
