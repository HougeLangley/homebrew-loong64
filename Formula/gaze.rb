class Gaze < Formula
  desc "Execute commands for you"
  homepage "https://example.org/gaze"
  version "1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/gaze--1.2.1.loongarch64.bottle.tar.gz"
  sha256 "ce490b36004d7d31abc6d3f4d1b81e0bbe7f85cd3b87256a29e166ed7558c277"

  def install
    bin.install "gaze"
  end

  test do
    system "#{bin}/gaze"
  end
end
