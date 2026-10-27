class Shuffledns < Formula
  desc "Enumerate subdomains using active bruteforce & resolve subdomains with wildcards"
  homepage "https://example.org/shuffledns"
  version "1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/shuffledns--1.2.1.loongarch64.bottle.tar.gz"
  sha256 "e590bd5b75acd70949119762d145a70dff5b60a70ba96ac06c2dfd5c8fd61753"

  def install
    bin.install "shuffledns"
  end

  test do
    system "#{bin}/shuffledns"
  end
end
