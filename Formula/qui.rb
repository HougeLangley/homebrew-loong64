class Qui < Formula
  desc "A fast, single-binary qBittorrent web UI: manage multiple instances, automate torrent work"
  homepage "https://example.org/qui"
  version "1.33.1"
  url "http://127.0.0.1:8080/brew/bottles/qui--1.33.1.loongarch64.bottle.tar.gz"
  sha256 "b5e4a9bd52925bc830ab85d8c4e997d0d17a629c1ff23c7dab7b738f684a3055"

  def install
    bin.install "qui"
  end

  test do
    system "#{bin}/qui"
  end
end
