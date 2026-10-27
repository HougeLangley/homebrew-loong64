class Sealed-secrets < Formula
  desc "A Kubernetes controller and tool for one-way encrypted Secrets"
  homepage "https://example.org/sealed-secrets"
  version "0.41.2"
  url "http://127.0.0.1:8080/brew/bottles/sealed-secrets--0.41.2.loongarch64.bottle.tar.gz"
  sha256 "5dc25c4e4f13f746cdf11d531c53eeae7092c6b0b5e19e8a2814ff3abf3cda7b"

  def install
    bin.install "sealed-secrets"
  end

  test do
    system "#{bin}/sealed-secrets"
  end
end
