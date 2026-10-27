class Kubernetes-cli@1.34 < Formula
  desc "Kubernetes command-line interface"
  homepage "https://example.org/kubernetes-cli@1.34"
  version "1.37.1"
  url "http://127.0.0.1:8080/brew/bottles/kubernetes-cli@1.34--1.37.1.loongarch64.bottle.tar.gz"
  sha256 "8ca6672333d3ca9f6a49ff71e19150aa0820e84f1f6849047c4ed0316c8dfd37"

  def install
    bin.install "kubernetes-cli@1.34"
  end

  test do
    system "#{bin}/kubernetes-cli@1.34"
  end
end
