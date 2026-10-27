class Helm@3 < Formula
  desc "Kubernetes package manager"
  homepage "https://example.org/helm@3"
  version "4.3.1"
  url "http://127.0.0.1:8080/brew/bottles/helm@3--4.3.1.loongarch64.bottle.tar.gz"
  sha256 "b5551567a0bcaa639c12869e04c0152c01c3e916f73f912e44a0eddc8b3f28fa"

  def install
    bin.install "helm@3"
  end

  test do
    system "#{bin}/helm@3"
  end
end
