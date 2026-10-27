class Stern < Formula
  desc "⎈ Multi pod and container log tailing for Kubernetes"
  homepage "https://example.org/stern"
  version "1.35.0"
  url "http://127.0.0.1:8080/brew/bottles/stern--1.35.0.loongarch64.bottle.tar.gz"
  sha256 "02c2c130315974e74cdb88cce2fb5ef45f7d76159ae7289e242a84f8723b2a64"

  def install
    bin.install "stern"
  end

  test do
    system "#{bin}/stern"
  end
end
