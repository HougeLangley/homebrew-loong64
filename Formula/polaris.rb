class Polaris < Formula
  desc "Validation of best practices in your Kubernetes clusters"
  homepage "https://example.org/polaris"
  version "10.2.5"
  url "http://127.0.0.1:8080/brew/bottles/polaris--10.2.5.loongarch64.bottle.tar.gz"
  sha256 "73fe2ca9af1f25af75e90aa293a9beb45211ac9a1531c67d81453d647c82e973"

  def install
    bin.install "polaris"
  end

  test do
    system "#{bin}/polaris"
  end
end
