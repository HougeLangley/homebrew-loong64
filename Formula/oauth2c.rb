class Oauth2c < Formula
  desc "User-friendly CLI for OAuth2"
  homepage "https://example.org/oauth2c"
  version "1.21.1"
  url "http://127.0.0.1:8080/brew/bottles/oauth2c--1.21.1.loongarch64.bottle.tar.gz"
  sha256 "a3236dd262f40f650d2c530b4bf55b0f216bfb244f2b7b968f948d9a121533ce"

  def install
    bin.install "oauth2c"
  end

  test do
    system "#{bin}/oauth2c"
  end
end
