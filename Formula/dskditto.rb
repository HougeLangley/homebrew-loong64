class Dskditto < Formula
  desc "Ultra-fast duplicate file finder TUI/GUI"
  homepage "https://example.org/dskditto"
  version "0.7.1"
  url "http://127.0.0.1:8080/brew/bottles/dskditto--0.7.1.loongarch64.bottle.tar.gz"
  sha256 "40b9b3c73bd59f327a0f20810b44bcaa18f3bedce132e58b6764f090ddf61bb4"

  def install
    bin.install "dskditto"
  end

  test do
    system "#{bin}/dskditto"
  end
end
