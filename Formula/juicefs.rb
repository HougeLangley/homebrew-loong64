class Juicefs < Formula
  desc "Cloud-based, distributed POSIX file system built on top of Redis and S3"
  homepage "https://example.org/juicefs"
  version "1.4.2"
  url "http://127.0.0.1:8080/brew/bottles/juicefs--1.4.2.loongarch64.bottle.tar.gz"
  sha256 "245f637e762421df8368131008e05c8bf3dba7c6eea40ebcd86852a7952800d7"

  def install
    bin.install "juicefs"
  end

  test do
    system "#{bin}/juicefs"
  end
end
