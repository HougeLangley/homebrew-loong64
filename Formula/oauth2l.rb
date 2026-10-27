class Oauth2l < Formula
  desc "Simple CLI for interacting with Google oauth tokens"
  homepage "https://example.org/oauth2l"
  version "1.3.6"
  url "http://127.0.0.1:8080/brew/bottles/oauth2l--1.3.6.loongarch64.bottle.tar.gz"
  sha256 "493f70cdac1ba149bcd0ca5f4cf1286ccac1ffbe680df04666153f7d5b081937"

  def install
    bin.install "oauth2l"
  end

  test do
    system "#{bin}/oauth2l"
  end
end
