class Kops < Formula
  desc "Kubernetes Operations (kOps) - Production Grade k8s Installation, Upgrades and Management"
  homepage "https://example.org/kops"
  version "1.36.2"
  url "http://127.0.0.1:8080/brew/bottles/kops--1.36.2.loongarch64.bottle.tar.gz"
  sha256 "57657a8ab8715cff1ffa967557bea93b74531a6a91a724f839571603fd3d5ec4"

  def install
    bin.install "kops"
  end

  test do
    system "#{bin}/kops"
  end
end
