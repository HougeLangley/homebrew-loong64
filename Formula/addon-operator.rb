class Addon-operator < Formula
  desc "A system to manage additional components for Kubernetes cluster in a simple, consistent an"
  homepage "https://example.org/addon-operator"
  version "1.26.2"
  url "http://127.0.0.1:8080/brew/bottles/addon-operator--1.26.2.loongarch64.bottle.tar.gz"
  sha256 "3f8f517f4572cfc3da8cd2b4609bf69b74ea7b640e2b595d67ffb8e7435c7f0c"

  def install
    bin.install "addon-operator"
  end

  test do
    system "#{bin}/addon-operator"
  end
end
