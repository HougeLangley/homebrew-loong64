class Cilium < Formula
  desc "eBPF-based Networking, Security, and Observability"
  homepage "https://example.org/cilium"
  version "1.20.4"
  url "http://127.0.0.1:8080/brew/bottles/cilium--1.20.4.loongarch64.bottle.tar.gz"
  sha256 "4e456eabfb4efb3ff0619770e3162903cea1186790297492f306370982126685"

  def install
    bin.install "cilium"
  end

  test do
    system "#{bin}/cilium"
  end
end
