class Pomo < Formula
  desc "Customizable TUI Pomodoro timer with ASCII art, progress bar, desktop notifications, and p"
  homepage "https://example.org/pomo"
  version "1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/pomo--1.2.1.loongarch64.bottle.tar.gz"
  sha256 "354e0767b61252b186c308832410499e8f23eebaf41cc29f57d92621fc494172"

  def install
    bin.install "pomo"
  end

  test do
    system "#{bin}/pomo"
  end
end
