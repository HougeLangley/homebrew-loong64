class Ecoji < Formula
  desc "Encodes (and decodes) data as emojis"
  homepage "https://example.org/ecoji"
  version "2.0.2"
  url "http://127.0.0.1:8080/brew/bottles/ecoji--2.0.2.loongarch64.bottle.tar.gz"
  sha256 "18ab5dd3ddedc3e2e1bce992ae9900bd87307d0005fd631bfe08fe14c7b5272c"

  def install
    bin.install "ecoji"
  end

  test do
    system "#{bin}/ecoji"
  end
end
