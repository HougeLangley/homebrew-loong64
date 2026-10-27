class Tfk8s < Formula
  desc "Kubernetes YAML manifests to Terraform HCL converter"
  homepage "https://example.org/tfk8s"
  version "0.1.10"
  url "http://127.0.0.1:8080/brew/bottles/tfk8s--0.1.10.loongarch64.bottle.tar.gz"
  sha256 "7142ce6a259568596cab3086b0512f6cad3b2ac987f0694ac13a989aabeb8a26"

  def install
    bin.install "tfk8s"
  end

  test do
    system "#{bin}/tfk8s"
  end
end
