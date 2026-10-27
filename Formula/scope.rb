class Scope < Formula
  desc "Monitoring, visualisation & management for Docker & Kubernetes"
  homepage "https://example.org/scope"
  version "1.13.2"
  url "http://127.0.0.1:8080/brew/bottles/scope--1.13.2.loongarch64.bottle.tar.gz"
  sha256 "a2c08a4cb4ff2a0b6338d71e44408564c0a1a8c739d58efee1b1e581bc6116a4"

  def install
    bin.install "scope"
  end

  test do
    system "#{bin}/scope"
  end
end
