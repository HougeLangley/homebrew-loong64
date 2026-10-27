class K2tf < Formula
  desc "Kubernetes YAML to Terraform HCL converter"
  homepage "https://example.org/k2tf"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/k2tf--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "86dfc63b6a80b618a01da22242c6b342d2157c5868c3be5c16d9e18e8da73f90"

  def install
    bin.install "k2tf"
  end

  test do
    system "#{bin}/k2tf"
  end
end
