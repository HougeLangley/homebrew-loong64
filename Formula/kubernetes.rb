class Kubernetes < Formula
  desc "Production-Grade Container Scheduling and Management"
  homepage "https://example.org/kubernetes"
  version "1.37.1"
  url "http://127.0.0.1:8080/brew/bottles/kubernetes--1.37.1.loongarch64.bottle.tar.gz"
  sha256 "f7fc6d48572c00fe8bf92f92bae673acd246e1bea4a79db6e922b517617fa856"

  def install
    bin.install "kubernetes"
  end

  test do
    system "#{bin}/kubernetes"
  end
end
