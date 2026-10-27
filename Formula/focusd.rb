class Focusd < Formula
  desc "Free, open-source screen time tracker for Windows. Monitors app usage, tracks browser tabs"
  homepage "https://example.org/focusd"
  version "3.0.0"
  url "http://127.0.0.1:8080/brew/bottles/focusd--3.0.0.loongarch64.bottle.tar.gz"
  sha256 "f33a515ff0e928d2fc79d7f274682c9d863ea348df8cd24e88403efb502a8d56"

  def install
    bin.install "focusd"
  end

  test do
    system "#{bin}/focusd"
  end
end
