class Mubeng < Formula
  desc "Incredibly fast proxy checker & IP rotator with ease"
  homepage "https://example.org/mubeng"
  version "0.23.0"
  url "http://127.0.0.1:8080/brew/bottles/mubeng--0.23.0.loongarch64.bottle.tar.gz"
  sha256 "ccdec68657a7aa8b914a3800e3f2e2fd82ca93aed2002972a617af5add83e185"

  def install
    bin.install "mubeng"
  end

  test do
    system "#{bin}/mubeng"
  end
end
