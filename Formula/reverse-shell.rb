class Reverse-shell < Formula
  desc "Reverse Shell as a Service"
  homepage "https://example.org/reverse-shell"
  version "1.1.3"
  url "http://127.0.0.1:8080/brew/bottles/reverse-shell--1.1.3.loongarch64.bottle.tar.gz"
  sha256 "e3caa1ea10baa024488335bf904c8f2a3c91a5f75f5c085b79b8ec00dc811799"

  def install
    bin.install "reverse-shell"
  end

  test do
    system "#{bin}/reverse-shell"
  end
end
