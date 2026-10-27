class Keyb < Formula
  desc "Create and view custom hotkey cheatsheets in the terminal"
  homepage "https://example.org/keyb"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/keyb--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "67c1c9f0b2a52164add4f5428931704b0e025ba75610911088ee94bd518d840e"

  def install
    bin.install "keyb"
  end

  test do
    system "#{bin}/keyb"
  end
end
