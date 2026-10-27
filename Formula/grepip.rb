class Grepip < Formula
  desc "Filters IPv4 & IPv6 addresses with a grep-compatible interface"
  homepage "https://example.org/grepip"
  version "ipinfo-3.3.3"
  url "http://127.0.0.1:8080/brew/bottles/grepip--ipinfo-3.3.3.loongarch64.bottle.tar.gz"
  sha256 "bc61f926e2f7c95df38fe4a53b2dc2bb093f01c3a8bafb58e4a182e460d70dbd"

  def install
    bin.install "grepip"
  end

  test do
    system "#{bin}/grepip"
  end
end
