class Dish < Formula
  desc "Lightweight monitoring service that efficiently checks socket connections"
  homepage "https://example.org/dish"
  version "1.12.0"
  url "http://127.0.0.1:8080/brew/bottles/dish--1.12.0.loongarch64.bottle.tar.gz"
  sha256 "2125241fc471718b8a0999921888cbff0ecf80d2dcb88980e1ff87331086cd8b"

  def install
    bin.install "dish"
  end

  test do
    system "#{bin}/dish"
  end
end
