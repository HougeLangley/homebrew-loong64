class Shuffledns < Formula
  desc "Enumerate subdomains using active bruteforce & resolve subdomains with wildcards"
  homepage "https://example.org/shuffledns"
  version "1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/shuffledns--1.2.1.loongarch64.bottle.tar.gz"
  sha256 "6c037ecb27a6fa8c442b9a4646c115ca9e3f0c5473a1dd4a0845f0ac3098084c"

  def install
    bin.install "shuffledns"
  end

  test do
    system "#{bin}/shuffledns"
  end
end
