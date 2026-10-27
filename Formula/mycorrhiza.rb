class Mycorrhiza < Formula
  desc "Lightweight wiki engine with hierarchy support"
  homepage "https://example.org/mycorrhiza"
  version "1.15.1"
  url "http://127.0.0.1:8080/brew/bottles/mycorrhiza--1.15.1.loongarch64.bottle.tar.gz"
  sha256 "d19c5ee318146283cf40af2a817fbf1021ffd55b2711366ae7ae9aa732f99a85"

  def install
    bin.install "mycorrhiza"
  end

  test do
    system "#{bin}/mycorrhiza"
  end
end
