class Cloudlist < Formula
  desc "Cloudlist is a tool for listing Assets from multiple Cloud Providers."
  homepage "https://example.org/cloudlist"
  version "1.5.0"
  url "http://127.0.0.1:8080/brew/bottles/cloudlist--1.5.0.loongarch64.bottle.tar.gz"
  sha256 "17d7a6576bbd97005868feb7c771cd18486abbe7dac9e9c243086838ce603c4a"

  def install
    bin.install "cloudlist"
  end

  test do
    system "#{bin}/cloudlist"
  end
end
