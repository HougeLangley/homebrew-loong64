class Prometheus < Formula
  desc "Service monitoring system and time series database"
  homepage "https://example.org/prometheus"
  version "3.15.1"
  url "http://127.0.0.1:8080/brew/bottles/prometheus--3.15.1.loongarch64.bottle.tar.gz"
  sha256 "9163b76bdc6e78c9e544bb8bccd97cc2e16b66aaae976a886ef75ea986b7c356"

  def install
    bin.install "prometheus"
  end

  test do
    system "#{bin}/prometheus"
  end
end
