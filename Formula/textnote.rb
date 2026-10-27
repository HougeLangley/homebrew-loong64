class Textnote < Formula
  desc "Simple tool for creating and organizing daily notes on the command line"
  homepage "https://example.org/textnote"
  version "1.3.2"
  url "http://127.0.0.1:8080/brew/bottles/textnote--1.3.2.loongarch64.bottle.tar.gz"
  sha256 "d9dfbb1e88d4855e1772d4afd50293a51442caa00d5d2fa3dedcb88411796c83"

  def install
    bin.install "textnote"
  end

  test do
    system "#{bin}/textnote"
  end
end
