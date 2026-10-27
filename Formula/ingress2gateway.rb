class Ingress2gateway < Formula
  desc "Convert Kubernetes Ingress resources to Kubernetes Gateway API resources"
  homepage "https://example.org/ingress2gateway"
  version "1.2.0"
  url "http://127.0.0.1:8080/brew/bottles/ingress2gateway--1.2.0.loongarch64.bottle.tar.gz"
  sha256 "76bbc15ee2edf0bc5339617cfa18c01c45d9094269541b45fd7aad8a7c28aef7"

  def install
    bin.install "ingress2gateway"
  end

  test do
    system "#{bin}/ingress2gateway"
  end
end
