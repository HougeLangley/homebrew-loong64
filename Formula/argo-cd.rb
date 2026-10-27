class Argo-cd < Formula
  desc "Declarative Continuous Deployment for Kubernetes"
  homepage "https://example.org/argo-cd"
  version "3.5.6"
  url "http://127.0.0.1:8080/brew/bottles/argo-cd--3.5.6.loongarch64.bottle.tar.gz"
  sha256 "459c5c736debf1f4644714166dfe9db34039afd58561ee382cfa08f098a826f8"

  def install
    bin.install "argo-cd"
  end

  test do
    system "#{bin}/argo-cd"
  end
end
