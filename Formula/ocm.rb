class Ocm < Formula
  desc "CLI for the Red Hat OpenShift Cluster Manager"
  homepage "https://example.org/ocm"
  version "1.0.17"
  url "http://127.0.0.1:8080/brew/bottles/ocm--1.0.17.loongarch64.bottle.tar.gz"
  sha256 "df19661a4591658507cf41d126c71b7d7d837c3155629cf1692a442d277d0061"

  def install
    bin.install "ocm"
  end

  test do
    system "#{bin}/ocm"
  end
end
