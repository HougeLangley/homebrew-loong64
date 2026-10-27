class Flagger < Formula
  desc "Progressive delivery Kubernetes operator (Canary, A/B Testing and Blue/Green deployments)"
  homepage "https://example.org/flagger"
  version "1.45.0"
  url "http://127.0.0.1:8080/brew/bottles/flagger--1.45.0.loongarch64.bottle.tar.gz"
  sha256 "d75a166acbcda54801fb2e0bb3649f9439b1253fc42b95a3363b6657826b9ce9"

  def install
    bin.install "flagger"
  end

  test do
    system "#{bin}/flagger"
  end
end
