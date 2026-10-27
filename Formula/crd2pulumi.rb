class Crd2pulumi < Formula
  desc "Generate typed CustomResources from a Kubernetes CustomResourceDefinition"
  homepage "https://example.org/crd2pulumi"
  version "1.6.2"
  url "http://127.0.0.1:8080/brew/bottles/crd2pulumi--1.6.2.loongarch64.bottle.tar.gz"
  sha256 "3533c7373db36fbb442f98a648d3810f8cd322c8d5bf08c0cf5227f76ca28cc2"

  def install
    bin.install "crd2pulumi"
  end

  test do
    system "#{bin}/crd2pulumi"
  end
end
