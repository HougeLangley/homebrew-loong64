class Kube-state-metrics < Formula
  desc "Add-on agent to generate and expose cluster-level metrics."
  homepage "https://example.org/kube-state-metrics"
  version "2.20.0"
  url "http://127.0.0.1:8080/brew/bottles/kube-state-metrics--2.20.0.loongarch64.bottle.tar.gz"
  sha256 "bcb5ae62ef57a38196a9c4d4e88a2a081641a12de6f4eff9681f3f3f7fc98f6c"

  def install
    bin.install "kube-state-metrics"
  end

  test do
    system "#{bin}/kube-state-metrics"
  end
end
