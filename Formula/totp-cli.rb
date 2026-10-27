class Totp-cli < Formula
  desc "Authy/Google Authenticator like TOTP CLI tool written in Go"
  homepage "https://example.org/totp-cli"
  version "1.9.2"
  url "http://127.0.0.1:8080/brew/bottles/totp-cli--1.9.2.loongarch64.bottle.tar.gz"
  sha256 "e76dc8da407438a05033002a347e6bab4562efdf208ab69e635e6d28d252f10a"

  def install
    bin.install "totp-cli"
  end

  test do
    system "#{bin}/totp-cli"
  end
end
