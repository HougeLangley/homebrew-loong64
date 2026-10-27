class Shell-operator < Formula
  desc "Shell-operator is a tool for running event-driven scripts in a Kubernetes cluster"
  homepage "https://example.org/shell-operator"
  version "1.21.3"
  url "http://127.0.0.1:8080/brew/bottles/shell-operator--1.21.3.loongarch64.bottle.tar.gz"
  sha256 "3f77dee3816f95663c5a2815909219c21b6420336c9c7ef3328a007215e55a35"

  def install
    bin.install "shell-operator"
  end

  test do
    system "#{bin}/shell-operator"
  end
end
