class Tronbyt-server < Formula
  desc "Manage your apps on your Tronbyt (flashed Tidbyt) completely locally"
  homepage "https://example.org/tronbyt-server"
  version "2.5.2"
  url "http://127.0.0.1:8080/brew/bottles/tronbyt-server--2.5.2.loongarch64.bottle.tar.gz"
  sha256 "5d1e836a0dedbc6d3f270f631e527fd3e5320e0b5f27cbc80bfe533379af627a"

  def install
    bin.install "tronbyt-server"
  end

  test do
    system "#{bin}/tronbyt-server"
  end
end
