class Rclone < Formula
  desc "Rsync for cloud storage"
  homepage "https://example.org/rclone"
  version "1.75.2"
  url "http://127.0.0.1:8080/brew/bottles/rclone--1.75.2.loongarch64.bottle.tar.gz"
  sha256 "cfb172d8549ad1d88bfd2ca56ec8cc08185553389baf21b8a17f98487668d0a9"

  def install
    bin.install "rclone"
  end

  test do
    system "#{bin}/rclone"
  end
end
