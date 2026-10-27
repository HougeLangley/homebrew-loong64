class Gits < Formula
  desc "Fast CLI Git manager for multiple repositories grouped by projects, with GitHub/GitLab/Bit"
  homepage "https://example.org/gits"
  version "0.64.0"
  url "http://127.0.0.1:8080/brew/bottles/gits--0.64.0.loongarch64.bottle.tar.gz"
  sha256 "0097d1078c295152e1343e24525fb4959d3b983fe4fa49c061c85b27baf0996a"

  def install
    bin.install "gits"
  end

  test do
    system "#{bin}/gits"
  end
end
