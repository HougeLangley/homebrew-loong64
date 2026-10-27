class Node_exporter < Formula
  desc "Prometheus exporter for machine metrics"
  homepage "https://example.org/node_exporter"
  version "1.12.1"
  url "http://127.0.0.1:8080/brew/bottles/node_exporter--1.12.1.loongarch64.bottle.tar.gz"
  sha256 "468ea613164b0495baee792c30fcbc547fe13d3fbbd4372730f50a6c602633cb"

  def install
    bin.install "node_exporter"
  end

  test do
    system "#{bin}/node_exporter"
  end
end
