class Istioctl < Formula
  desc "Istio configuration command-line utility"
  homepage "https://example.org/istioctl"
  version "1.31.3"
  url "http://127.0.0.1:8080/brew/bottles/istioctl--1.31.3.loongarch64.bottle.tar.gz"
  sha256 "fd64f2449a2cb499e95405979c77a82d8703f17a80c2a344dcb202efab45b693"

  def install
    bin.install "istioctl"
  end

  test do
    system "#{bin}/istioctl"
  end
end
