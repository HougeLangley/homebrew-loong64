class Smap < Formula
  desc "Drop-in replacement for Nmap powered by shodan.io"
  homepage "https://example.org/smap"
  version "1.0.0-beta"
  url "http://127.0.0.1:8080/brew/bottles/smap--1.0.0-beta.loongarch64.bottle.tar.gz"
  sha256 "f69d71266a3221d061c08029d6a7c2f0dc574f7978e8e8b4c0900d10ef64e13e"

  def install
    bin.install "smap"
  end

  test do
    system "#{bin}/smap"
  end
end
