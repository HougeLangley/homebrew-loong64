class Tldx < Formula
  desc "Bulk domain availability checking via RDAP, DNS, and WHOIS, with prefix/suffix permutation"
  homepage "https://example.org/tldx"
  version "1.6.0"
  url "http://127.0.0.1:8080/brew/bottles/tldx--1.6.0.loongarch64.bottle.tar.gz"
  sha256 "6e93c5e889c9f30c6cace6e2c67d0b6adf13c15b80ec8aabc0c7adad667a346d"

  def install
    bin.install "tldx"
  end

  test do
    system "#{bin}/tldx"
  end
end
