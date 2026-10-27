class Karmada < Formula
  desc "Open, Multi-Cloud, Multi-Cluster Kubernetes Orchestration"
  homepage "https://example.org/karmada"
  version "1.19.0"
  url "http://127.0.0.1:8080/brew/bottles/karmada--1.19.0.loongarch64.bottle.tar.gz"
  sha256 "f01f01bc9e965ff1730e0a7cbbfcf17cdc9a9d30221629cd20873e1a7295e29f"

  def install
    bin.install "karmada"
  end

  test do
    system "#{bin}/karmada"
  end
end
