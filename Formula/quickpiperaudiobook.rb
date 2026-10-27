class Quickpiperaudiobook < Formula
  desc "With one command, create a natural-sounding audiobook from a variety of input formats (epu"
  homepage "https://example.org/quickpiperaudiobook"
  version "0.0.7"
  url "http://127.0.0.1:8080/brew/bottles/quickpiperaudiobook--0.0.7.loongarch64.bottle.tar.gz"
  sha256 "914f27acf14fe983362f3481f8ce1d3b4e7f5947f1658cab50704f10bce35f96"

  def install
    bin.install "quickpiperaudiobook"
  end

  test do
    system "#{bin}/quickpiperaudiobook"
  end
end
