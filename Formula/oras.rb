class Oras < Formula
  desc "OCI registry client - managing content like artifacts, images, packages"
  homepage "https://example.org/oras"
  version "1.3.6"
  url "http://127.0.0.1:8080/brew/bottles/oras--1.3.6.loongarch64.bottle.tar.gz"
  sha256 "d64dd8cdd32f111e3ce60b0d71e8fd9c10ed68ef990dbf92d068a9798d8e0ee9"

  def install
    bin.install "oras"
  end

  test do
    system "#{bin}/oras"
  end
end
