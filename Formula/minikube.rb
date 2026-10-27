class Minikube < Formula
  desc "Run Kubernetes locally"
  homepage "https://example.org/minikube"
  version "1.39.0"
  url "http://127.0.0.1:8080/brew/bottles/minikube--1.39.0.loongarch64.bottle.tar.gz"
  sha256 "08ee7f3a21efdd434794be8ce08907435da01a197583c8e6a26d561de2ff79ae"

  def install
    bin.install "minikube"
  end

  test do
    system "#{bin}/minikube"
  end
end
