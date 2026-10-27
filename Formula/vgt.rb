class Vgt < Formula
  desc "Visualising Go Tests"
  homepage "https://example.org/vgt"
  version "1.0.1"
  url "http://127.0.0.1:8080/brew/bottles/vgt--1.0.1.loongarch64.bottle.tar.gz"
  sha256 "0dac14f38e56a28a9cbf92b41e62eefd57102089d370c2dd72440e1ecbc6a538"

  def install
    bin.install "vgt"
  end

  test do
    system "#{bin}/vgt"
  end
end
