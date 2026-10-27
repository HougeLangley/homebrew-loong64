class Videoalchemy < Formula
  desc "Toolkit expanding video processing capabilities"
  homepage "https://example.org/videoalchemy"
  version "1.0.0"
  url "http://127.0.0.1:8080/brew/bottles/videoalchemy--1.0.0.loongarch64.bottle.tar.gz"
  sha256 "41c482ba412513b2aff63fd3af9ce91d72c75d3036971ae28a6f49a6d1b71ba9"

  def install
    bin.install "videoalchemy"
  end

  test do
    system "#{bin}/videoalchemy"
  end
end
