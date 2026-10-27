class Color < Formula
  desc "🎨 Terminal color rendering library, support 8/16 colors, 256 colors, RGB color rendering o"
  homepage "https://example.org/color"
  version "1.6.3"
  url "http://127.0.0.1:8080/brew/bottles/color--1.6.3.loongarch64.bottle.tar.gz"
  sha256 "58e3812f1d375dee2bd0e1e7c85523b9f396343d4ef5f2ed8a7b16563e794369"

  def install
    bin.install "color"
  end

  test do
    system "#{bin}/color"
  end
end
