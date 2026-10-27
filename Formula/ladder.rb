class Ladder < Formula
  desc "Selfhosted alternative to 12ft.io and 1ft.io HTTP web proxies"
  homepage "https://example.org/ladder"
  version "0.0.23"
  url "http://127.0.0.1:8080/brew/bottles/ladder--0.0.23.loongarch64.bottle.tar.gz"
  sha256 "6ac119c60e50346c81b2fdec47b51078e016fb25b23f330335bbcee94499d6e9"

  def install
    bin.install "ladder"
  end

  test do
    system "#{bin}/ladder"
  end
end
