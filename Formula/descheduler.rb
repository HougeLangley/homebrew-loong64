class Descheduler < Formula
  desc "Descheduler for Kubernetes"
  homepage "https://example.org/descheduler"
  version "descheduler-helm-chart-0.37.0"
  url "http://127.0.0.1:8080/brew/bottles/descheduler--descheduler-helm-chart-0.37.0.loongarch64.bottle.tar.gz"
  sha256 "8f1e49d8e69c3403f187c2d72ad9ea2eda9c45789c57ea9053e3ec00886769dc"

  def install
    bin.install "descheduler"
  end

  test do
    system "#{bin}/descheduler"
  end
end
