class Ttt < Formula
  desc "TTT Editor (Terminal Text Tool): A real alternative to VS Code, Zed, and Sublime that runs"
  homepage "https://example.org/ttt"
  version "1.9.0"
  url "http://127.0.0.1:8080/brew/bottles/ttt--1.9.0.loongarch64.bottle.tar.gz"
  sha256 "0b11635a7421de0cd2f5e17afd4ac7185c0351b90f7494b00246da905aef4092"

  def install
    bin.install "ttt"
  end

  test do
    system "#{bin}/ttt"
  end
end
