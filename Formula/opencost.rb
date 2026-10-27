class Opencost < Formula
  desc "Cost monitoring for Kubernetes workloads and cloud costs"
  homepage "https://example.org/opencost"
  version "1.121.3"
  url "http://127.0.0.1:8080/brew/bottles/opencost--1.121.3.loongarch64.bottle.tar.gz"
  sha256 "4db028bbdc4242e2089f626d3138b2e0ce802e898d165125edb77dd568f18970"

  def install
    bin.install "opencost"
  end

  test do
    system "#{bin}/opencost"
  end
end
