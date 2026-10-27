class Kube-router < Formula
  desc "Kube-router, a turnkey solution for Kubernetes networking."
  homepage "https://example.org/kube-router"
  version "2.11.2"
  url "http://127.0.0.1:8080/brew/bottles/kube-router--2.11.2.loongarch64.bottle.tar.gz"
  sha256 "4c8511f45eef067904b8c787310d9a0e51882cfb2462fec2bca6ea8eecd516f5"

  def install
    bin.install "kube-router"
  end

  test do
    system "#{bin}/kube-router"
  end
end
