class Dry < Formula
  desc "dry - A Docker manager for the terminal @"
  homepage "https://example.org/dry"
  version "0.13.0"
  url "http://127.0.0.1:8080/brew/bottles/dry--0.13.0.loongarch64.bottle.tar.gz"
  sha256 "fbcc68612688be2b2da3154fc8646cdc5cb5d8375619644ad532c85f472d6205"

  def install
    bin.install "dry"
  end

  test do
    system "#{bin}/dry"
  end
end
