class Mp4ff < Formula
  desc "Tools for parsing and manipulating MP4/ISOBMFF files"
  homepage "https://example.org/mp4ff"
  version "0.60.0"
  url "http://127.0.0.1:8080/brew/bottles/mp4ff--0.60.0.loongarch64.bottle.tar.gz"
  sha256 "cfc5b25d2a601a2aed0a6797ae1772f9d4b9ecd9e63a158768dfa92e5a9cfedf"

  def install
    bin.install "mp4ff"
  end

  test do
    system "#{bin}/mp4ff"
  end
end
