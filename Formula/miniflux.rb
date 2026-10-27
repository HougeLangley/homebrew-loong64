class Miniflux < Formula
  desc "Minimalist and opinionated feed reader"
  homepage "https://example.org/miniflux"
  version "2.3.4"
  url "http://127.0.0.1:8080/brew/bottles/miniflux--2.3.4.loongarch64.bottle.tar.gz"
  sha256 "0fa450b487c52bc8250b0b2bece2c10e5878829ce1f5b00d9ff3a9df5e763f29"

  def install
    bin.install "miniflux"
  end

  test do
    system "#{bin}/miniflux"
  end
end
