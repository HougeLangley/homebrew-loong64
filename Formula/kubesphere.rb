class Kubesphere < Formula
  desc "The container platform tailored for Kubernetes multi-cloud, datacenter, and edge managemen"
  homepage "https://example.org/kubesphere"
  version "4.1.3"
  url "http://127.0.0.1:8080/brew/bottles/kubesphere--4.1.3.loongarch64.bottle.tar.gz"
  sha256 "f2b6d5dae5662bec0b56441dc4792a01742d10b07e2b0e82d70b1751b1104ae7"

  def install
    bin.install "kubesphere"
  end

  test do
    system "#{bin}/kubesphere"
  end
end
