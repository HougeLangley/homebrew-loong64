class Cobra < Formula
  desc "A Commander for modern Go CLI interactions"
  homepage "https://example.org/cobra"
  version "1.10.2"
  url "http://127.0.0.1:8080/brew/bottles/cobra--1.10.2.loongarch64.bottle.tar.gz"
  sha256 "f283b3bce79f14a4e22813e1fa648807917cd9518e849c4ff472f2ecabb79d8a"

  def install
    bin.install "cobra"
  end

  test do
    system "#{bin}/cobra"
  end
end
