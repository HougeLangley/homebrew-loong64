class Hcloud < Formula
  desc "Command-line interface for Hetzner Cloud"
  homepage "https://example.org/hcloud"
  version "1.70.2"
  url "http://127.0.0.1:8080/brew/bottles/hcloud--1.70.2.loongarch64.bottle.tar.gz"
  sha256 "4c0f484ebab624362017eb02ae201399bdd2c55597409610195c7a700171344c"

  def install
    bin.install "hcloud"
  end

  test do
    system "#{bin}/hcloud"
  end
end
