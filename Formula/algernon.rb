class Algernon < Formula
  desc "Pure Go web server with Lua, Markdown, HTTP/2 and template support"
  homepage "https://example.org/algernon"
  version "1.17.12"
  url "http://127.0.0.1:8080/brew/bottles/algernon--1.17.12.loongarch64.bottle.tar.gz"
  sha256 "1a83e7ea80366b8f2b7cea11cebd635b79e2d502be2c31f1487a13cccb321332"

  def install
    bin.install "algernon"
  end

  test do
    system "#{bin}/algernon"
  end
end
