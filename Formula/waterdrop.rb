class Waterdrop < Formula
  desc "💧Waterdrop is a high performance micro service framework. Waterdrop comes from (The Three "
  homepage "https://example.org/waterdrop"
  version "1.3.8"
  url "http://127.0.0.1:8080/brew/bottles/waterdrop--1.3.8.loongarch64.bottle.tar.gz"
  sha256 "8b9a5aaee9e7feae7860206f0b66d3609abba896c0fdf31e0ed8a4c9a2199cfd"

  def install
    bin.install "waterdrop"
  end

  test do
    system "#{bin}/waterdrop"
  end
end
