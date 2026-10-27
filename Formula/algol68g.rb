class Algol68g < Formula
  desc "Algol 68 compiler-interpreter"
  homepage "https://example.org/algol68g"
  version "3.13.4"
  url "http://127.0.0.1:8080/brew/bottles/algol68g--3.13.4.loongarch64.bottle.tar.gz"
  sha256 "a32825d4e2a4fcedb882f4afd952448e4e0a7d620e077e47f3d49a94eff2b417"

  def install
    bin.install "algol68g"
  end

  test do
    system "#{bin}/algol68g"
  end
end
