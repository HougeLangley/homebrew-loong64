class Kubeshark < Formula
  desc "eBPF-powered network observability for Kubernetes. Indexes L4/L7 traffic with full K8s con"
  homepage "https://example.org/kubeshark"
  version "53.6.0"
  url "http://127.0.0.1:8080/brew/bottles/kubeshark--53.6.0.loongarch64.bottle.tar.gz"
  sha256 "463f2ec26300d9f3a3fe7095e1fa63d5bb62144d1e7f944f3d4fd71f175320db"

  def install
    bin.install "kubeshark"
  end

  test do
    system "#{bin}/kubeshark"
  end
end
