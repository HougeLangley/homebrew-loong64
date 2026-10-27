class Kubekey < Formula
  desc "Installer for Kubernetes and / or KubeSphere, and related cloud-native add-ons"
  homepage "https://example.org/kubekey"
  version "4.0.8"
  url "http://127.0.0.1:8080/brew/bottles/kubekey--4.0.8.loongarch64.bottle.tar.gz"
  sha256 "dc06c772f57f25130e18eb224d21e3a2f0485e644badd89c596736414c1ba642"

  def install
    bin.install "kubekey"
  end

  test do
    system "#{bin}/kubekey"
  end
end
