class Harsh < Formula
  desc "Habit tracking for geeks"
  homepage "https://example.org/harsh"
  version "0.14.5"
  url "http://127.0.0.1:8080/brew/bottles/harsh--0.14.5.loongarch64.bottle.tar.gz"
  sha256 "b7491fdced5f91a101200b6ec22ef4e7d272d2a0b37597214724d162d252d205"

  def install
    bin.install "harsh"
  end

  test do
    system "#{bin}/harsh"
  end
end
