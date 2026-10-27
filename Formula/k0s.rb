class K0s < Formula
  desc "k0s - The Zero Friction Kubernetes"
  homepage "https://example.org/k0s"
  version "1.36.4+k0s.1"
  url "http://127.0.0.1:8080/brew/bottles/k0s--1.36.4+k0s.1.loongarch64.bottle.tar.gz"
  sha256 "102865d2a3f02d242274d1a42ce95ac988b841eb1e76e907f8318932b12710d7"

  def install
    bin.install "k0s"
  end

  test do
    system "#{bin}/k0s"
  end
end
