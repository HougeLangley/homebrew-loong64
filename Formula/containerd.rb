class Containerd < Formula
  desc "An open and reliable container runtime"
  homepage "https://example.org/containerd"
  version "2.4.2"
  url "http://127.0.0.1:8080/brew/bottles/containerd--2.4.2.loongarch64.bottle.tar.gz"
  sha256 "2f99cabbea55d92c94ea23f45d889d080b6fc202622cb37989cbe4847b6014ad"

  def install
    bin.install "containerd"
  end

  test do
    system "#{bin}/containerd"
  end
end
