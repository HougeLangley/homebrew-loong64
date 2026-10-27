class Kubefirst < Formula
  desc "GitOps Infrastructure & Application Delivery Platform for kubernetes"
  homepage "https://example.org/kubefirst"
  version "2.10.5"
  url "http://127.0.0.1:8080/brew/bottles/kubefirst--2.10.5.loongarch64.bottle.tar.gz"
  sha256 "524ed0fd5ae63c466d8f254c94ee96179856af0e4d5d8d985e5db8de3aab5e3e"

  def install
    bin.install "kubefirst"
  end

  test do
    system "#{bin}/kubefirst"
  end
end
