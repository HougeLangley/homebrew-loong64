class Typist < Formula
  desc "A cross-platform CLI and Web UI typing application built for developers to master speed an"
  homepage "https://example.org/typist"
  version "2.0.1"
  url "http://127.0.0.1:8080/brew/bottles/typist--2.0.1.loongarch64.bottle.tar.gz"
  sha256 "2a1f1bd69407d3bae218c853cba859f39487055f2e2c7ac9aa51af37aebc835e"

  def install
    bin.install "typist"
  end

  test do
    system "#{bin}/typist"
  end
end
