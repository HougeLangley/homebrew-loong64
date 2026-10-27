class Go-http-metrics < Formula
  desc "Go modular http middleware to measure HTTP requests independent of metrics backend (with P"
  homepage "https://example.org/go-http-metrics"
  version "0.13.0"
  url "http://127.0.0.1:8080/brew/bottles/go-http-metrics--0.13.0.loongarch64.bottle.tar.gz"
  sha256 "80058b980fcf5d54a034c9795d462bbef8d08ece157081df57dd8a133037a845"

  def install
    bin.install "go-http-metrics"
  end

  test do
    system "#{bin}/go-http-metrics"
  end
end
