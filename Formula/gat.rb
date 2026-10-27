class Gat < Formula
  desc "Cat alternative written in Go"
  homepage "https://example.org/gat"
  version "0.31.0"
  url "http://127.0.0.1:8080/brew/bottles/gat--0.31.0.loongarch64.bottle.tar.gz"
  sha256 "39c655f67560f871041464b3dc91182c6ca449676ff2dae31adef901c30fec54"

  def install
    bin.install "gat"
  end

  test do
    system "#{bin}/gat"
  end
end
