class Aerospace-marks < Formula
  desc "Vim like marks for Aerospace WM"
  homepage "https://example.org/aerospace-marks"
  version "1.0.3"
  url "http://127.0.0.1:8080/brew/bottles/aerospace-marks--1.0.3.loongarch64.bottle.tar.gz"
  sha256 "7ca7029466b41793c72e34bd7edf6832f769ddf85c968878774891018dbb76eb"

  def install
    bin.install "aerospace-marks"
  end

  test do
    system "#{bin}/aerospace-marks"
  end
end
