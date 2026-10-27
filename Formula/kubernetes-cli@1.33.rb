class Kubernetes-cli@1.33 < Formula
  desc "Kubernetes command-line interface"
  homepage "https://example.org/kubernetes-cli@1.33"
  version "1.37.1"
  url "http://127.0.0.1:8080/brew/bottles/kubernetes-cli@1.33--1.37.1.loongarch64.bottle.tar.gz"
  sha256 "ac907ebf1670b655dbe2e8622025e4702ec8205a5b4e5444256bfa5f2d1561aa"

  def install
    bin.install "kubernetes-cli@1.33"
  end

  test do
    system "#{bin}/kubernetes-cli@1.33"
  end
end
