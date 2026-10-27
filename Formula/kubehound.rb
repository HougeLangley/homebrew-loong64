class Kubehound < Formula
  desc "Tool for building Kubernetes attack paths"
  homepage "https://example.org/kubehound"
  version "1.6.7"
  url "http://127.0.0.1:8080/brew/bottles/kubehound--1.6.7.loongarch64.bottle.tar.gz"
  sha256 "9bb4c0908a6b49724f9dbd0797b10c157fa5768fb024bf3fec23ccbc3aead4d3"

  def install
    bin.install "kubehound"
  end

  test do
    system "#{bin}/kubehound"
  end
end
