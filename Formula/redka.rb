class Redka < Formula
  desc "Redis re-implemented with SQLite"
  homepage "https://example.org/redka"
  version "1.0.1"
  url "http://127.0.0.1:8080/brew/bottles/redka--1.0.1.loongarch64.bottle.tar.gz"
  sha256 "74f3409bc9fa47754a473a05dd2a9a846bc5c79d625f3a56babe5d11c9a883d4"

  def install
    bin.install "redka"
  end

  test do
    system "#{bin}/redka"
  end
end
