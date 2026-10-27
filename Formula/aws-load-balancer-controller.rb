class Aws-load-balancer-controller < Formula
  desc "A Kubernetes controller for Elastic Load Balancers"
  homepage "https://example.org/aws-load-balancer-controller"
  version "3.6.2"
  url "http://127.0.0.1:8080/brew/bottles/aws-load-balancer-controller--3.6.2.loongarch64.bottle.tar.gz"
  sha256 "da41739564c110fac22704fbcb771a79cd0021afeb3fb736a2c85c2ab8ab6df8"

  def install
    bin.install "aws-load-balancer-controller"
  end

  test do
    system "#{bin}/aws-load-balancer-controller"
  end
end
