class Descope < Formula
  desc "Command-line utility for performing common tasks on Descope projects"
  homepage "https://example.org/descope"
  version "0.8.16"
  url "http://127.0.0.1:8080/brew/bottles/descope--0.8.16.loongarch64.bottle.tar.gz"
  sha256 "42b74307ba4b255ab209239a8648e4ba22d0b356efd6fcdbe1f01d1bd5a39f73"

  def install
    bin.install "descope"
  end

  test do
    system "#{bin}/descope"
  end
end
