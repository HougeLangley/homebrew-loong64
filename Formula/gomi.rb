class Gomi < Formula
  desc "Functions like rm but with the ability to restore files"
  homepage "https://example.org/gomi"
  version "1.10.1"
  url "http://127.0.0.1:8080/brew/bottles/gomi--1.10.1.loongarch64.bottle.tar.gz"
  sha256 "be772ada328efd1d17ed2a4c036e96058f81644079ff7e76517b5d77ff7fb2ad"

  def install
    bin.install "gomi"
  end

  test do
    system "#{bin}/gomi"
  end
end
