class Keda < Formula
  desc " KEDA is a Kubernetes-based Event Driven Autoscaling component. It provides event driven s"
  homepage "https://example.org/keda"
  version "2.21.0"
  url "http://127.0.0.1:8080/brew/bottles/keda--2.21.0.loongarch64.bottle.tar.gz"
  sha256 "a171a3d02cc563861dd72104032e643252fd8adc3c96db20c11421e0f1c033e2"

  def install
    bin.install "keda"
  end

  test do
    system "#{bin}/keda"
  end
end
