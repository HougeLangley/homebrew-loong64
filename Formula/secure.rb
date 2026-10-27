class Secure < Formula
  desc "HTTP middleware for Go that facilitates some quick security wins."
  homepage "https://example.org/secure"
  version "1.17.0"
  url "http://127.0.0.1:8080/brew/bottles/secure--1.17.0.loongarch64.bottle.tar.gz"
  sha256 "a99f758397c2b855aa515b34e5d27c7d34e4f3bb4fed8b2933646b7a0c75f8c9"

  def install
    bin.install "secure"
  end

  test do
    system "#{bin}/secure"
  end
end
