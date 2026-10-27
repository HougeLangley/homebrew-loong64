class Goshot < Formula
  desc "🎨 Create beautiful code screenshots with customizable styles "
  homepage "https://example.org/goshot"
  version "0.8.1"
  url "http://127.0.0.1:8080/brew/bottles/goshot--0.8.1.loongarch64.bottle.tar.gz"
  sha256 "c188ac264f5a0abf3ee5200f476e4f20a3fa5cb8909db79f72af7fd81224d569"

  def install
    bin.install "goshot"
  end

  test do
    system "#{bin}/goshot"
  end
end
