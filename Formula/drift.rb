class Drift < Formula
  desc "Terminal screensaver that activates when you're idle, constellations, rain, particles & mo"
  homepage "https://example.org/drift"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/drift--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "80b007e9663523d47ba68da92b192c0dea4d0e046eac5df48612a28bffbb6c36"

  def install
    bin.install "drift"
  end

  test do
    system "#{bin}/drift"
  end
end
