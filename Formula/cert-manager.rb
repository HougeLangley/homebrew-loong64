class Cert-manager < Formula
  desc "Automatically provision and manage TLS certificates in Kubernetes"
  homepage "https://example.org/cert-manager"
  version "1.21.3"
  url "http://127.0.0.1:8080/brew/bottles/cert-manager--1.21.3.loongarch64.bottle.tar.gz"
  sha256 "30e9b26e1d67adee10df2fc974c4180473895d2677ae3cb0e685c35425513a99"

  def install
    bin.install "cert-manager"
  end

  test do
    system "#{bin}/cert-manager"
  end
end
