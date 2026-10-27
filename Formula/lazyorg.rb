class Lazyorg < Formula
  desc "Simple terminal-based calendar and note-taking app"
  homepage "https://example.org/lazyorg"
  version "1.1.1"
  url "http://127.0.0.1:8080/brew/bottles/lazyorg--1.1.1.loongarch64.bottle.tar.gz"
  sha256 "2196e917efad9a25e812ddbd3ce232de7a8f54a6ef563d4c96054046fba1a3fc"

  def install
    bin.install "lazyorg"
  end

  test do
    system "#{bin}/lazyorg"
  end
end
