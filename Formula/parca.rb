class Parca < Formula
  desc "Continuous profiling for analysis of CPU and memory usage"
  homepage "https://example.org/parca"
  version "0.29.1"
  url "http://127.0.0.1:8080/brew/bottles/parca--0.29.1.loongarch64.bottle.tar.gz"
  sha256 "0ddc71c9b467441e4c44bc6b3e077be6565205f09dbf32afc830908e28d80c30"

  def install
    bin.install "parca"
  end

  test do
    system "#{bin}/parca"
  end
end
