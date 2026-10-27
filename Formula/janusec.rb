class Janusec < Formula
  desc "JANUSEC Application Gateway provides secure access, including reverse proxy, K8S Ingress C"
  homepage "https://example.org/janusec"
  version "1.6.1"
  url "http://127.0.0.1:8080/brew/bottles/janusec--1.6.1.loongarch64.bottle.tar.gz"
  sha256 "2e06417dde3ac1ff67eb94beb4fa1b7dd5fb33868b87af195d0a2397ca369614"

  def install
    bin.install "janusec"
  end

  test do
    system "#{bin}/janusec"
  end
end
