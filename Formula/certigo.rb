class Certigo < Formula
  desc "Utility to examine and validate certificates in a variety of formats"
  homepage "https://example.org/certigo"
  version "1.18.2"
  url "http://127.0.0.1:8080/brew/bottles/certigo--1.18.2.loongarch64.bottle.tar.gz"
  sha256 "3ec96174638a957e52474e14d21e0f1a0181ee2a4a19620f18599ac2e56cef94"

  def install
    bin.install "certigo"
  end

  test do
    system "#{bin}/certigo"
  end
end
