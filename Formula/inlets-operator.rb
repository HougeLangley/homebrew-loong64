class Inlets-operator < Formula
  desc "Get public TCP LoadBalancers for local Kubernetes clusters"
  homepage "https://example.org/inlets-operator"
  version "0.17.23"
  url "http://127.0.0.1:8080/brew/bottles/inlets-operator--0.17.23.loongarch64.bottle.tar.gz"
  sha256 "f85611e39c7ccb02e7594474ae11391d07008b9f6cb9b9b30690852e465c7e94"

  def install
    bin.install "inlets-operator"
  end

  test do
    system "#{bin}/inlets-operator"
  end
end
