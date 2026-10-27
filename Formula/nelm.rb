class Nelm < Formula
  desc "Nelm is a Helm 4 alternative. It is a Kubernetes deployment tool that manages Helm Charts "
  homepage "https://example.org/nelm"
  version "1.29.0"
  url "http://127.0.0.1:8080/brew/bottles/nelm--1.29.0.loongarch64.bottle.tar.gz"
  sha256 "945d3f4ddf4466912c80174169d2784b4d187390e0ec452851abd0852764fbc8"

  def install
    bin.install "nelm"
  end

  test do
    system "#{bin}/nelm"
  end
end
