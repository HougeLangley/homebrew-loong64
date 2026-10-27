class Cheat < Formula
  desc "Create and view interactive cheat sheets for *nix commands"
  homepage "https://example.org/cheat"
  version "5.1.0"
  url "http://127.0.0.1:8080/brew/bottles/cheat--5.1.0.loongarch64.bottle.tar.gz"
  sha256 "5f6dc6dc05fa78978005135ffe4df9c148a4d5664072868d53d8c7caaf37c52d"

  def install
    bin.install "cheat"
  end

  test do
    system "#{bin}/cheat"
  end
end
