class Vim < Formula
  desc "Vi IMproved, a programmer's text editor"
  homepage "https://example.org/vim"
  version "9.2.1242"
  url "http://127.0.0.1:8080/brew/bottles/vim--9.2.1242.loongarch64.bottle.tar.gz"
  sha256 "637e649bc26d261d7e9a775f11e030e9a23fdefb7e3241feedf9d4183e3368df"

  def install
    bin.install "vim"
  end

  test do
    system "#{bin}/vim"
  end
end
