class Aerospace-scratchpad < Formula
  desc "Scratchpad for AeroSpace WM"
  homepage "https://example.org/aerospace-scratchpad"
  version "0.7.1"
  url "http://127.0.0.1:8080/brew/bottles/aerospace-scratchpad--0.7.1.loongarch64.bottle.tar.gz"
  sha256 "001376f0f0bb059fbbe35a48869e01a8c8ba558fc62222797e56a6adc5cadc38"

  def install
    bin.install "aerospace-scratchpad"
  end

  test do
    system "#{bin}/aerospace-scratchpad"
  end
end
