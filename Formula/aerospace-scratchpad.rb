class Aerospace-scratchpad < Formula
  desc "Scratchpad for AeroSpace WM"
  homepage "https://example.org/aerospace-scratchpad"
  version "0.7.1"
  url "http://127.0.0.1:8080/brew/bottles/aerospace-scratchpad--0.7.1.loongarch64.bottle.tar.gz"
  sha256 "d2878572cf3f7bbe6ab3715e82f3bc402c1ccf5800f42ae8dd2f5fc779fb2752"

  def install
    bin.install "aerospace-scratchpad"
  end

  test do
    system "#{bin}/aerospace-scratchpad"
  end
end
