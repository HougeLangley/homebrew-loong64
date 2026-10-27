class Addon-controller < Formula
  desc "Sveltos Kubernetes add-on controller programmatically deploys add-ons and applications in "
  homepage "https://example.org/addon-controller"
  version "1.16.1"
  url "http://127.0.0.1:8080/brew/bottles/addon-controller--1.16.1.loongarch64.bottle.tar.gz"
  sha256 "ee404340ac27864975bc1fde1ec3223678c90ea7e8f6652239af72a409219043"

  def install
    bin.install "addon-controller"
  end

  test do
    system "#{bin}/addon-controller"
  end
end
