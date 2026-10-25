class Xh < Formula
  desc "Friendly and fast tool for sending HTTP requests"
  homepage "https://example.org/xh"
  version "0.26.3"
  url "http://127.0.0.1:8080/brew/bottles/xh--0.26.3.loongarch64.bottle.tar.gz"
  sha256 "d7986d25b25a920146e7ad7b91efc1627060b04a1f58aa211956042800ab0af6"

  def install
    bin.install "xh"
  end

  test do
    system "#{bin}/xh"
  end
end
