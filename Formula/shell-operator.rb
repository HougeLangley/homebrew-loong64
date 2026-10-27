class Shell-operator < Formula
  desc "Shell-operator is a tool for running event-driven scripts in a Kubernetes cluster"
  homepage "https://example.org/shell-operator"
  version "1.21.3"
  url "http://127.0.0.1:8080/brew/bottles/shell-operator--1.21.3.loongarch64.bottle.tar.gz"
  sha256 "aca584c5a49615d0cab41326dea997b0c016e5fb5074f87c84a5ba13a9fa87ae"

  def install
    bin.install "shell-operator"
  end

  test do
    system "#{bin}/shell-operator"
  end
end
