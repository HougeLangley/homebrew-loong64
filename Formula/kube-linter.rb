class Kube-linter < Formula
  desc "Static analysis tool for Kubernetes YAML files and Helm charts"
  homepage "https://example.org/kube-linter"
  version "0.8.3"
  url "http://127.0.0.1:8080/brew/bottles/kube-linter--0.8.3.loongarch64.bottle.tar.gz"
  sha256 "56761fc839d8ff5e9878a04bec5ee117ee0ad9d0cebf817247ee9d86a26e9f85"

  def install
    bin.install "kube-linter"
  end

  test do
    system "#{bin}/kube-linter"
  end
end
