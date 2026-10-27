class Kubevpn < Formula
  desc "KubeVPN offers a Cloud Native Dev Environment that connects to kubernetes cluster network."
  homepage "https://example.org/kubevpn"
  version "2.11.10"
  url "http://127.0.0.1:8080/brew/bottles/kubevpn--2.11.10.loongarch64.bottle.tar.gz"
  sha256 "8baef5c1a28727c97234929e9764757d7d259a55a3ecb6fd2a62424198623bfd"

  def install
    bin.install "kubevpn"
  end

  test do
    system "#{bin}/kubevpn"
  end
end
