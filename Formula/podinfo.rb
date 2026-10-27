class Podinfo < Formula
  desc "Go microservice template for Kubernetes"
  homepage "https://example.org/podinfo"
  version "6.17.0"
  url "http://127.0.0.1:8080/brew/bottles/podinfo--6.17.0.loongarch64.bottle.tar.gz"
  sha256 "1301bd6075849f8fbff8cf4ef5995322edfa8cc0fc8784f22f7afd55b18f0df0"

  def install
    bin.install "podinfo"
  end

  test do
    system "#{bin}/podinfo"
  end
end
