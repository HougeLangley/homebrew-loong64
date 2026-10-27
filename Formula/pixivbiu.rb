class Pixivbiu < Formula
  desc "Pixiv client. Easy to search, browse, and download artworks"
  homepage "https://example.org/pixivbiu"
  version "3.1.6"
  url "http://127.0.0.1:8080/brew/bottles/pixivbiu--3.1.6.loongarch64.bottle.tar.gz"
  sha256 "e4fe7635209a3ed87bc2f5b7cd7a19e832429d68c02d53f225b234618413549e"

  def install
    bin.install "pixivbiu"
  end

  test do
    system "#{bin}/pixivbiu"
  end
end
