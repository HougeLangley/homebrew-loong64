class Difftastic < Formula
  desc "Structural diff tool"
  homepage "https://example.org/difftastic"
  version "0.71.0"
  url "http://127.0.0.1:8080/brew/bottles/difftastic--0.71.0.loongarch64.bottle.tar.gz"
  sha256 "98edcc089cac0f369d2f41f1e4bc89fca16ffe4f9c50a87f8a255f6a72c6e0f2"

  def install
    bin.install "difftastic"
  end

  test do
    system "#{bin}/difftastic"
  end
end
