class Kubernetes-cli@1.33 < Formula
  desc "Kubernetes command-line interface"
  homepage "https://example.org/kubernetes-cli@1.33"
  version "1.37.1"
  url "http://127.0.0.1:8080/brew/bottles/kubernetes-cli@1.33--1.37.1.loongarch64.bottle.tar.gz"
  sha256 "f5f8ed9096db79d5aca49f9e7451a53b74403bb8356bb30304e1f91932d359ab"

  def install
    bin.install "kubernetes-cli@1.33"
  end

  test do
    system "#{bin}/kubernetes-cli@1.33"
  end
end
