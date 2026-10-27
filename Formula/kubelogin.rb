class Kubelogin < Formula
  desc "OpenID Connect authentication plugin for kubectl"
  homepage "https://example.org/kubelogin"
  version "1.36.4"
  url "http://127.0.0.1:8080/brew/bottles/kubelogin--1.36.4.loongarch64.bottle.tar.gz"
  sha256 "7a08952a75c02294463349482d77c96a348959d0652175f6e427840cc5e925b7"

  def install
    bin.install "kubelogin"
  end

  test do
    system "#{bin}/kubelogin"
  end
end
