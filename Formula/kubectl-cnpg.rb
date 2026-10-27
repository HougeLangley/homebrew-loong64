class Kubectl-cnpg < Formula
  desc "CloudNativePG plugin for kubectl"
  homepage "https://example.org/kubectl-cnpg"
  version "1.30.1"
  url "http://127.0.0.1:8080/brew/bottles/kubectl-cnpg--1.30.1.loongarch64.bottle.tar.gz"
  sha256 "f7c0e46fb5b2b3433d1aa61a624bd365106d1952bd9c63bfad046bc5edcc7d1b"

  def install
    bin.install "kubectl-cnpg"
  end

  test do
    system "#{bin}/kubectl-cnpg"
  end
end
