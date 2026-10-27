class Kubernetes-cli@1.32 < Formula
  desc "Kubernetes command-line interface"
  homepage "https://example.org/kubernetes-cli@1.32"
  version "1.37.1"
  url "http://127.0.0.1:8080/brew/bottles/kubernetes-cli@1.32--1.37.1.loongarch64.bottle.tar.gz"
  sha256 "9a4851ee5a837a020280f2b17e70de4f830e5b97c697150a4e0a7291eacb4957"

  def install
    bin.install "kubernetes-cli@1.32"
  end

  test do
    system "#{bin}/kubernetes-cli@1.32"
  end
end
