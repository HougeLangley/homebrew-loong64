class Bacon < Formula
  desc "Background code checker"
  homepage "https://example.org/bacon"
  version "3.26.0"
  url "http://127.0.0.1:8080/brew/bottles/bacon--3.26.0.loongarch64.bottle.tar.gz"
  sha256 "0637137253cb220688f2c770d2a996dc2515e2c99fb806633fcf911572cdbb85"

  def install
    bin.install "bacon"
  end

  test do
    system "#{bin}/bacon"
  end
end
