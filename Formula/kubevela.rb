class Kubevela < Formula
  desc "The Modern Application Platform."
  homepage "https://example.org/kubevela"
  version "1.11.0"
  url "http://127.0.0.1:8080/brew/bottles/kubevela--1.11.0.loongarch64.bottle.tar.gz"
  sha256 "b892c15a565c4678869073622d0489930105eb060843bb82413f31afd1e99dee"

  def install
    bin.install "kubevela"
  end

  test do
    system "#{bin}/kubevela"
  end
end
