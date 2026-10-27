class Mist < Formula
  desc "A distributed, tag-based pub-sub service for modern web applications and container-driven "
  homepage "https://example.org/mist"
  version "1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/mist--1.2.1.loongarch64.bottle.tar.gz"
  sha256 "7b9d0bc7b6c2d9d1a22c5c5e60db6b7e48d6c6af0382da0d45d310c7a9f6a66d"

  def install
    bin.install "mist"
  end

  test do
    system "#{bin}/mist"
  end
end
