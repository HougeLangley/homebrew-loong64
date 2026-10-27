class Kubetrim < Formula
  desc "Trim your KUBECONFIG automatically"
  homepage "https://example.org/kubetrim"
  version "0.0.3"
  url "http://127.0.0.1:8080/brew/bottles/kubetrim--0.0.3.loongarch64.bottle.tar.gz"
  sha256 "a6f4036c73f0f8aa0a3c9dfe8717bb4964326ef4f1b2a71d049c80c87e47bc83"

  def install
    bin.install "kubetrim"
  end

  test do
    system "#{bin}/kubetrim"
  end
end
