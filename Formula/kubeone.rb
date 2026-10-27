class Kubeone < Formula
  desc "Automate cluster operations on all your environments"
  homepage "https://example.org/kubeone"
  version "1.14.4"
  url "http://127.0.0.1:8080/brew/bottles/kubeone--1.14.4.loongarch64.bottle.tar.gz"
  sha256 "37cb627c7e3569c77abd3305c76c7f07e90f9b587ab9a3e45de6acaa9ee15ea0"

  def install
    bin.install "kubeone"
  end

  test do
    system "#{bin}/kubeone"
  end
end
