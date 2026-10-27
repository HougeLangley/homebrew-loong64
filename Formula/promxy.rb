class Promxy < Formula
  desc "An aggregating proxy to enable HA prometheus"
  homepage "https://example.org/promxy"
  version "0.0.97"
  url "http://127.0.0.1:8080/brew/bottles/promxy--0.0.97.loongarch64.bottle.tar.gz"
  sha256 "1757eba848abd224439d0bf6930a35a29348cbff013a566424ccd71977604816"

  def install
    bin.install "promxy"
  end

  test do
    system "#{bin}/promxy"
  end
end
