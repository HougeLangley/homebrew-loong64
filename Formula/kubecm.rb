class Kubecm < Formula
  desc "KubeConfig Manager"
  homepage "https://example.org/kubecm"
  version "0.35.1"
  url "http://127.0.0.1:8080/brew/bottles/kubecm--0.35.1.loongarch64.bottle.tar.gz"
  sha256 "11d25771139d646c920604c81a2288c8e6b977c31eaf596fa883b5ab57d6dd2d"

  def install
    bin.install "kubecm"
  end

  test do
    system "#{bin}/kubecm"
  end
end
