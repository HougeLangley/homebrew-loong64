class Convoy < Formula
  desc "The Cloud Native Webhooks Gateway"
  homepage "https://example.org/convoy"
  version "26.9.2"
  url "http://127.0.0.1:8080/brew/bottles/convoy--26.9.2.loongarch64.bottle.tar.gz"
  sha256 "d907ab64dc8bd1b673f2f59d64aea347dd07095abc2172a38179e5acc425e11e"

  def install
    bin.install "convoy"
  end

  test do
    system "#{bin}/convoy"
  end
end
