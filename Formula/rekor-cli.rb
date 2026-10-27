class Rekor-cli < Formula
  desc "CLI for interacting with Rekor"
  homepage "https://example.org/rekor-cli"
  version "1.5.5"
  url "http://127.0.0.1:8080/brew/bottles/rekor-cli--1.5.5.loongarch64.bottle.tar.gz"
  sha256 "88c6e3823d9afb8573990067b926a5c3e857ff8568ee5f99ee702572ff8d1afe"

  def install
    bin.install "rekor-cli"
  end

  test do
    system "#{bin}/rekor-cli"
  end
end
