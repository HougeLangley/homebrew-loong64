class Prometheus-operator < Formula
  desc "Prometheus Operator creates/configures/manages Prometheus clusters atop Kubernetes"
  homepage "https://example.org/prometheus-operator"
  version "0.94.2"
  url "http://127.0.0.1:8080/brew/bottles/prometheus-operator--0.94.2.loongarch64.bottle.tar.gz"
  sha256 "5d430d7ab47bb114fdfc53744b0f523b7e7a413c542eb915a90f24918450f8a7"

  def install
    bin.install "prometheus-operator"
  end

  test do
    system "#{bin}/prometheus-operator"
  end
end
