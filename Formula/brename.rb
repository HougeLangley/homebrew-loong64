class Brename < Formula
  desc "Cross-platform command-line tool for safe batch renaming via regular expressions"
  homepage "https://example.org/brename"
  version "2.14.0"
  url "http://127.0.0.1:8080/brew/bottles/brename--2.14.0.loongarch64.bottle.tar.gz"
  sha256 "4d7259d79a6f8e3aa9cb307c30b1aaeac8324d5380ca54d0be703c5a0e0fe577"

  def install
    bin.install "brename"
  end

  test do
    system "#{bin}/brename"
  end
end
