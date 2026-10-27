class M3 < Formula
  desc "M3 monorepo - Distributed TSDB, Aggregator and Query Engine, Prometheus Sidecar, Graphite "
  homepage "https://example.org/m3"
  version "1.6.0"
  url "http://127.0.0.1:8080/brew/bottles/m3--1.6.0.loongarch64.bottle.tar.gz"
  sha256 "53620b538514279818cc44dc99f9866bb456a5f8849a7597bf8aa75b840fceca"

  def install
    bin.install "m3"
  end

  test do
    system "#{bin}/m3"
  end
end
