class Cherry < Formula
  desc "🍒 Cherry — Go game server framework powered by Actor Model. Serial goroutine per actor, NA"
  homepage "https://example.org/cherry"
  version "1.6.9"
  url "http://127.0.0.1:8080/brew/bottles/cherry--1.6.9.loongarch64.bottle.tar.gz"
  sha256 "725fab5ea9a2dc518f24f2d1d3381aa95f2977140f85651624860aa1df7c239d"

  def install
    bin.install "cherry"
  end

  test do
    system "#{bin}/cherry"
  end
end
