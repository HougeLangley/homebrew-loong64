class Kubernetes-cli@1.35 < Formula
  desc "Kubernetes command-line interface"
  homepage "https://example.org/kubernetes-cli@1.35"
  version "1.37.1"
  url "http://127.0.0.1:8080/brew/bottles/kubernetes-cli@1.35--1.37.1.loongarch64.bottle.tar.gz"
  sha256 "52319f8550328218cd224e21883868b451a7cee740bf75e7a1c6fced7a7ebd4f"

  def install
    bin.install "kubernetes-cli@1.35"
  end

  test do
    system "#{bin}/kubernetes-cli@1.35"
  end
end
