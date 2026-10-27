class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://example.org/clusterctl"
  version "1.14.3"
  url "http://127.0.0.1:8080/brew/bottles/clusterctl--1.14.3.loongarch64.bottle.tar.gz"
  sha256 "44c5092b7d419d7035bf472b249729e67a0aed269410d302629cfc743cc8b011"

  def install
    bin.install "clusterctl"
  end

  test do
    system "#{bin}/clusterctl"
  end
end
