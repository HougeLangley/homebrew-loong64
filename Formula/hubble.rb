class Hubble < Formula
  desc "Network, Service & Security Observability for Kubernetes using eBPF"
  homepage "https://example.org/hubble"
  version "1.20.2"
  url "http://127.0.0.1:8080/brew/bottles/hubble--1.20.2.loongarch64.bottle.tar.gz"
  sha256 "fba1ded51a62d138e37c22adae3b5d7495b15951ff8f2e1300d16cad3210e5a9"

  def install
    bin.install "hubble"
  end

  test do
    system "#{bin}/hubble"
  end
end
