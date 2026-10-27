class Azuretls-client < Formula
  desc "An easy-to-use HTTP client to spoof TLS/JA3, HTTP2 and HTTP3 fingerprint"
  homepage "https://example.org/azuretls-client"
  version "1.13.2"
  url "http://127.0.0.1:8080/brew/bottles/azuretls-client--1.13.2.loongarch64.bottle.tar.gz"
  sha256 "631b0bdfde69aa97b5d7b4124be9c70ad301a7b0965e4be8260384bbadc53e9d"

  def install
    bin.install "azuretls-client"
  end

  test do
    system "#{bin}/azuretls-client"
  end
end
