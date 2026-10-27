class Air < Formula
  desc "☁️ Live reload for Go apps"
  homepage "https://example.org/air"
  version "1.67.4"
  url "http://127.0.0.1:8080/brew/bottles/air--1.67.4.loongarch64.bottle.tar.gz"
  sha256 "2ab648974f5c3454c1997d688f31b213577a9d0804e870b1b26d70e72a281ef5"

  def install
    bin.install "air"
  end

  test do
    system "#{bin}/air"
  end
end
