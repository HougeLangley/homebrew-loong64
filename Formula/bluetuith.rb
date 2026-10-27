class Bluetuith < Formula
  desc "Cross-platform TUI bluetooth manager"
  homepage "https://example.org/bluetuith"
  version "0.2.7"
  url "http://127.0.0.1:8080/brew/bottles/bluetuith--0.2.7.loongarch64.bottle.tar.gz"
  sha256 "23d30b0af2c133a1b0ec4e2ca0c8783ef8b8673d3078b75ab0e17ff69b5772c5"

  def install
    bin.install "bluetuith"
  end

  test do
    system "#{bin}/bluetuith"
  end
end
