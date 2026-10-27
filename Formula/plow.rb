class Plow < Formula
  desc "A high-performance HTTP benchmarking tool that includes a real-time web UI and terminal di"
  homepage "https://example.org/plow"
  version "1.4.0"
  url "http://127.0.0.1:8080/brew/bottles/plow--1.4.0.loongarch64.bottle.tar.gz"
  sha256 "964327803a532f86498e67949fe52ee4b06982bd5847b2f559acc3cf96f05dc8"

  def install
    bin.install "plow"
  end

  test do
    system "#{bin}/plow"
  end
end
