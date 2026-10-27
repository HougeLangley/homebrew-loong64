class Gosint < Formula
  desc "OSINT Swiss Army Knife"
  homepage "https://example.org/gosint"
  version "0.5"
  url "http://127.0.0.1:8080/brew/bottles/gosint--0.5.loongarch64.bottle.tar.gz"
  sha256 "25c1c0382fd21466d564d154d03397dc9c6749bd41315d8a7eb37f5d63c3d29b"

  def install
    bin.install "gosint"
  end

  test do
    system "#{bin}/gosint"
  end
end
