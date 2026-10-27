class Tele < Formula
  desc "Keyboard-first Telegram client for the terminal, written in Go"
  homepage "https://example.org/tele"
  version "2.0.2"
  url "http://127.0.0.1:8080/brew/bottles/tele--2.0.2.loongarch64.bottle.tar.gz"
  sha256 "99d301b27c4a93cb36cd192e2efdc35b09eeb8c2eb275192a439dbafbce0e784"

  def install
    bin.install "tele"
  end

  test do
    system "#{bin}/tele"
  end
end
