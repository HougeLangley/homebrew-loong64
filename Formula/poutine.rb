class Poutine < Formula
  desc "poutine, a supply chain vulnerability scanner for build pipelines"
  homepage "https://example.org/poutine"
  version "1.1.6"
  url "http://127.0.0.1:8080/brew/bottles/poutine--1.1.6.loongarch64.bottle.tar.gz"
  sha256 "5d11babb663479d12c02397029201ae8e57e39d574739126cbdfad78cb8fefe2"

  def install
    bin.install "poutine"
  end

  test do
    system "#{bin}/poutine"
  end
end
