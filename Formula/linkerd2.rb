class Linkerd2 < Formula
  desc "Ultralight, security-first service mesh for Kubernetes. Main repo for Linkerd 2.x."
  homepage "https://example.org/linkerd2"
  version "edge-26.10.1"
  url "http://127.0.0.1:8080/brew/bottles/linkerd2--edge-26.10.1.loongarch64.bottle.tar.gz"
  sha256 "4781b1aebe26b7c1a63ce4c01db1522bebb073efa089b196a0ff062b0fca41e6"

  def install
    bin.install "linkerd2"
  end

  test do
    system "#{bin}/linkerd2"
  end
end
