class Goto < Formula
  desc "Easy to use terminal SSH manager with advanced features. Binaries included! 😉"
  homepage "https://example.org/goto"
  version "1.6.1"
  url "http://127.0.0.1:8080/brew/bottles/goto--1.6.1.loongarch64.bottle.tar.gz"
  sha256 "5bbe3c74d6947f943e87346f55f08bcd212414ba8b97ed92b165fd51111b1e2f"

  def install
    bin.install "goto"
  end

  test do
    system "#{bin}/goto"
  end
end
