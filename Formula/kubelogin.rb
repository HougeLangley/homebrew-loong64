class Kubelogin < Formula
  desc "OpenID Connect authentication plugin for kubectl"
  homepage "https://example.org/kubelogin"
  version "1.36.4"
  url "http://127.0.0.1:8080/brew/bottles/kubelogin--1.36.4.loongarch64.bottle.tar.gz"
  sha256 "eb19f54f14a5ff377f3956758a6116d5c3c2938fc1c659a7f4eaa13f717e5705"

  def install
    bin.install "kubelogin"
  end

  test do
    system "#{bin}/kubelogin"
  end
end
