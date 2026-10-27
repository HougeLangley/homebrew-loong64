class Massren < Formula
  desc "Easily rename multiple files using your text editor"
  homepage "https://example.org/massren"
  version "1.5.7"
  url "http://127.0.0.1:8080/brew/bottles/massren--1.5.7.loongarch64.bottle.tar.gz"
  sha256 "6bf8e030a509b14000aa7b10548869263e130e4b6f5f486123498a6ce4a0b29f"

  def install
    bin.install "massren"
  end

  test do
    system "#{bin}/massren"
  end
end
