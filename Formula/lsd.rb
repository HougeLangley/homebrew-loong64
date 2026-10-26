class Lsd < Formula
  desc "Modern ls with colors and icons"
  homepage "https://example.org/lsd"
  version "1.2.0"
  url "http://127.0.0.1:8080/brew/bottles/lsd--1.2.0.loongarch64.bottle.tar.gz"
  sha256 "1921a275f3bae52d6ae98f87e77d5691c20ceb45acced999b375c5d9187fa2d1"

  def install
    bin.install "lsd"
  end

  test do
    system "#{bin}/lsd"
  end
end
