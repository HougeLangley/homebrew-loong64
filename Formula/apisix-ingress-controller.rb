class Apisix-ingress-controller < Formula
  desc "APISIX Ingress Controller for Kubernetes"
  homepage "https://example.org/apisix-ingress-controller"
  version "2.2.0"
  url "http://127.0.0.1:8080/brew/bottles/apisix-ingress-controller--2.2.0.loongarch64.bottle.tar.gz"
  sha256 "118260e518453504935cfb2004d6022a281e98014abadf1921af2686a8f4a4e6"

  def install
    bin.install "apisix-ingress-controller"
  end

  test do
    system "#{bin}/apisix-ingress-controller"
  end
end
