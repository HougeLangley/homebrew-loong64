class Zstd < Formula
  desc "Fast lossless compression algorithm"
  homepage "https://example.org/zstd"
  version "1.5.7"
  url "http://127.0.0.1:8080/brew/bottles/zstd--1.5.7.loongarch64.bottle.tar.gz"
  sha256 "44068455a81b3d60e9b632b2160968c5ce6e8e8cdf1f422ad3e4472778dce3e6"

  def install
    bin.install "zstd"
  end

  test do
    system "#{bin}/zstd"
  end
end
