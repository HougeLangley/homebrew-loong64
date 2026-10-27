class Flannel < Formula
  desc "flannel is a network fabric for containers, designed for Kubernetes"
  homepage "https://example.org/flannel"
  version "0.28.10"
  url "http://127.0.0.1:8080/brew/bottles/flannel--0.28.10.loongarch64.bottle.tar.gz"
  sha256 "1d1a06e26a3bfc49a56a6a4207cc206bf23c402db2575fdbb5298456ead66f14"

  def install
    bin.install "flannel"
  end

  test do
    system "#{bin}/flannel"
  end
end
