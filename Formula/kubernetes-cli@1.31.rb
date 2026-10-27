class Kubernetes-cli@1.31 < Formula
  desc "Kubernetes command-line interface"
  homepage "https://example.org/kubernetes-cli@1.31"
  version "1.37.1"
  url "http://127.0.0.1:8080/brew/bottles/kubernetes-cli@1.31--1.37.1.loongarch64.bottle.tar.gz"
  sha256 "fe1a6b90172d94e1a439856d62910aad33b0695fcaa0b0d2822f4214265ef838"

  def install
    bin.install "kubernetes-cli@1.31"
  end

  test do
    system "#{bin}/kubernetes-cli@1.31"
  end
end
