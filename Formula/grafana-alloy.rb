class Grafana-alloy < Formula
  desc "OpenTelemetry Collector distribution with programmable pipelines"
  homepage "https://example.org/grafana-alloy"
  version "1.21.2"
  url "http://127.0.0.1:8080/brew/bottles/grafana-alloy--1.21.2.loongarch64.bottle.tar.gz"
  sha256 "92cff5af183e3e0ee1eab1a40f894b1aac21b92dfd22a6b2c22f3f8cb946fd3b"

  def install
    bin.install "grafana-alloy"
  end

  test do
    system "#{bin}/grafana-alloy"
  end
end
