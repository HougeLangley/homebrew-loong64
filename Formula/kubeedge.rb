class Kubeedge < Formula
  desc "Kubernetes Native Edge Computing Framework (project under CNCF)"
  homepage "https://example.org/kubeedge"
  version "1.23.1"
  url "http://127.0.0.1:8080/brew/bottles/kubeedge--1.23.1.loongarch64.bottle.tar.gz"
  sha256 "8e23c07fcc5e65a1b97a6f2e15379151047716f10d309be3c22f8b7ff1a620f4"

  def install
    bin.install "kubeedge"
  end

  test do
    system "#{bin}/kubeedge"
  end
end
