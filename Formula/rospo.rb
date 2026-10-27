class Rospo < Formula
  desc "🐸 Effortless persistent SSH tunnels with embedded server for seamless connectivity"
  homepage "https://example.org/rospo"
  version "0.15.3"
  url "http://127.0.0.1:8080/brew/bottles/rospo--0.15.3.loongarch64.bottle.tar.gz"
  sha256 "9fa9f2f24386cd6970cab50efdd89aa8d7c2c11b9addf028ed7d1b6954b888d5"

  def install
    bin.install "rospo"
  end

  test do
    system "#{bin}/rospo"
  end
end
