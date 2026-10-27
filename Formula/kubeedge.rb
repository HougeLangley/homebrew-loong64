class Kubeedge < Formula
  desc "Kubernetes Native Edge Computing Framework (project under CNCF)"
  homepage "https://example.org/kubeedge"
  version "1.23.1"
  url "http://127.0.0.1:8080/brew/bottles/kubeedge--1.23.1.loongarch64.bottle.tar.gz"
  sha256 "0bd87103e0cf51b32d3f6554c41e492c4c902c6b2aa7636df99e2c83f69c6cdb"

  def install
    bin.install "kubeedge"
  end

  test do
    system "#{bin}/kubeedge"
  end
end
