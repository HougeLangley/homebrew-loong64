class Beads < Formula
  desc "Memory upgrade for your coding agent"
  homepage "https://example.org/beads"
  version "1.3.2"
  url "http://127.0.0.1:8080/brew/bottles/beads--1.3.2.loongarch64.bottle.tar.gz"
  sha256 "aaf5763582d9891e14e80e9d00669e1fd13aec0701792ef78b708a5277d1dc53"

  def install
    bin.install "beads"
  end

  test do
    system "#{bin}/beads"
  end
end
