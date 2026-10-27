class Glooctl < Formula
  desc "Envoy-Powered API Gateway"
  homepage "https://example.org/glooctl"
  version "1.22.7"
  url "http://127.0.0.1:8080/brew/bottles/glooctl--1.22.7.loongarch64.bottle.tar.gz"
  sha256 "bf402f1ff5776cb37fd940f9e238f3e4b53aeb276d95ffb4cbbc8a355ead1180"

  def install
    bin.install "glooctl"
  end

  test do
    system "#{bin}/glooctl"
  end
end
