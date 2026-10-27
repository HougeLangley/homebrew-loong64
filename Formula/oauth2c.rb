class Oauth2c < Formula
  desc "User-friendly CLI for OAuth2"
  homepage "https://example.org/oauth2c"
  version "1.21.1"
  url "http://127.0.0.1:8080/brew/bottles/oauth2c--1.21.1.loongarch64.bottle.tar.gz"
  sha256 "fadb8bcc0afe1ada99639ae25cfefdbfca8e15454bbd756b5966e2b455b43804"

  def install
    bin.install "oauth2c"
  end

  test do
    system "#{bin}/oauth2c"
  end
end
