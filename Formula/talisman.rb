class Talisman < Formula
  desc "Using a pre-commit hook, Talisman validates the outgoing changeset for things that look su"
  homepage "https://example.org/talisman"
  version "1.37.0"
  url "http://127.0.0.1:8080/brew/bottles/talisman--1.37.0.loongarch64.bottle.tar.gz"
  sha256 "05e17498b9ccd0b39efb98883e97efcf4d8932d95f9eb52f0fffb25a5205d958"

  def install
    bin.install "talisman"
  end

  test do
    system "#{bin}/talisman"
  end
end
