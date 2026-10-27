class Peco < Formula
  desc "Simplistic interactive filtering tool"
  homepage "https://example.org/peco"
  version "0.6.0"
  url "http://127.0.0.1:8080/brew/bottles/peco--0.6.0.loongarch64.bottle.tar.gz"
  sha256 "23f88d20b8a1c9ce2d69305ffedc01e587604da72900a52faa573a483d94086c"

  def install
    bin.install "peco"
  end

  test do
    system "#{bin}/peco"
  end
end
