class Fm < Formula
  desc "A terminal based file manager"
  homepage "https://example.org/fm"
  version "1.2.0"
  url "http://127.0.0.1:8080/brew/bottles/fm--1.2.0.loongarch64.bottle.tar.gz"
  sha256 "77bd4344768df60085c5e6288898fee7a701aacf0d07d1154836b03b906d8cee"

  def install
    bin.install "fm"
  end

  test do
    system "#{bin}/fm"
  end
end
