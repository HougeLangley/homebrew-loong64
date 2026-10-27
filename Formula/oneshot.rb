class Oneshot < Formula
  desc "A first-come first-served single-fire HTTP server. Easily transfer files to and from your "
  homepage "https://example.org/oneshot"
  version "2.1.1"
  url "http://127.0.0.1:8080/brew/bottles/oneshot--2.1.1.loongarch64.bottle.tar.gz"
  sha256 "03e027126a243c802f290cb30e1b41d8574acab1451336895d7d6de1cae7241a"

  def install
    bin.install "oneshot"
  end

  test do
    system "#{bin}/oneshot"
  end
end
