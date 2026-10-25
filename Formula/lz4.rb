class Lz4 < Formula
  desc "Extremely fast compression algorithm"
  homepage "https://example.org/lz4"
  version "1.10.0"
  url "http://127.0.0.1:8080/brew/bottles/lz4--1.10.0.loongarch64.bottle.tar.gz"
  sha256 "be4b4c6ab61d86aa394b8db16f4e96a41d5f95c6f2fc6976036a70bad130b2bc"

  def install
    bin.install "lz4"
  end

  test do
    system "#{bin}/lz4"
  end
end
