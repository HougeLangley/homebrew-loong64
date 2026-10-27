class Deja < Formula
  desc "Predictive inline suggestions for zsh"
  homepage "https://example.org/deja"
  version "0.4.2"
  url "http://127.0.0.1:8080/brew/bottles/deja--0.4.2.loongarch64.bottle.tar.gz"
  sha256 "de1b344faeca27914fd725477c63338349c53f07b896ec4de829dfb11fb5ed67"

  def install
    bin.install "deja"
  end

  test do
    system "#{bin}/deja"
  end
end
