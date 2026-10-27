class Opengist < Formula
  desc "Self-hosted pastebin powered by Git, open-source alternative to Github Gist."
  homepage "https://example.org/opengist"
  version "1.15.3"
  url "http://127.0.0.1:8080/brew/bottles/opengist--1.15.3.loongarch64.bottle.tar.gz"
  sha256 "4a16f2506e29e5baf0b061301ddd672e8b2c6e68a969572748f5187dd5c5e80b"

  def install
    bin.install "opengist"
  end

  test do
    system "#{bin}/opengist"
  end
end
