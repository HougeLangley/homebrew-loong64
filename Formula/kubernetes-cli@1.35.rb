class Kubernetes-cli@1.35 < Formula
  desc "Kubernetes command-line interface"
  homepage "https://example.org/kubernetes-cli@1.35"
  version "1.37.1"
  url "http://127.0.0.1:8080/brew/bottles/kubernetes-cli@1.35--1.37.1.loongarch64.bottle.tar.gz"
  sha256 "8ca3fb27842aacf8418322c14819fffc61b7cc09b30521d78c57cf416e09f300"

  def install
    bin.install "kubernetes-cli@1.35"
  end

  test do
    system "#{bin}/kubernetes-cli@1.35"
  end
end
