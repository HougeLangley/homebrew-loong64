class Cluster-api-provider-hetzner < Formula
  desc "Cluster API Provider Hetzner :rocket: The best way to manage Kubernetes clusters on Hetzne"
  homepage "https://example.org/cluster-api-provider-hetzner"
  version "1.1.10"
  url "http://127.0.0.1:8080/brew/bottles/cluster-api-provider-hetzner--1.1.10.loongarch64.bottle.tar.gz"
  sha256 "f48dbf053e0affd53da3fa87a16f075bb13e0327c89362bd83385466e6cd37db"

  def install
    bin.install "cluster-api-provider-hetzner"
  end

  test do
    system "#{bin}/cluster-api-provider-hetzner"
  end
end
