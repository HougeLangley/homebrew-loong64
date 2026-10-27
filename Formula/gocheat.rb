class Gocheat < Formula
  desc "A beautiful customizable TUI Cheatsheet for keybindings,hotkeys and more in the terminal "
  homepage "https://example.org/gocheat"
  version "0.1.1"
  url "http://127.0.0.1:8080/brew/bottles/gocheat--0.1.1.loongarch64.bottle.tar.gz"
  sha256 "135edfdac17cb1ee5fb38a1e95b23f6ae38e84ac49a896039e5759151e022333"

  def install
    bin.install "gocheat"
  end

  test do
    system "#{bin}/gocheat"
  end
end
