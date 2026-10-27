class Virtual-kubelet < Formula
  desc "Virtual Kubelet is an open source Kubernetes kubelet implementation."
  homepage "https://example.org/virtual-kubelet"
  version "1.14.1"
  url "http://127.0.0.1:8080/brew/bottles/virtual-kubelet--1.14.1.loongarch64.bottle.tar.gz"
  sha256 "2d4226c749ac46f361196fe253d2299784a7874825cbdb4b77e12ea6283e7119"

  def install
    bin.install "virtual-kubelet"
  end

  test do
    system "#{bin}/virtual-kubelet"
  end
end
