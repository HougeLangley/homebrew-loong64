class Metallb < Formula
  desc "A network load-balancer implementation for Kubernetes using standard routing protocols"
  homepage "https://example.org/metallb"
  version "metallb-chart-0.16.1"
  url "http://127.0.0.1:8080/brew/bottles/metallb--metallb-chart-0.16.1.loongarch64.bottle.tar.gz"
  sha256 "a6d343c5bfbb4e9c5db943fa0012d17ed47464988e97a907d8a4485880f5ec69"

  def install
    bin.install "metallb"
  end

  test do
    system "#{bin}/metallb"
  end
end
