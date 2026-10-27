class Dnscrypt-proxy < Formula
  desc "Secure communications between a client and a DNS resolver"
  homepage "https://example.org/dnscrypt-proxy"
  version "2.1.20"
  url "http://127.0.0.1:8080/brew/bottles/dnscrypt-proxy--2.1.20.loongarch64.bottle.tar.gz"
  sha256 "e38081ae3dfbdfda96b7e515f73fd9bb5fc25e56efa48f28357d6b0e67e0ad5b"

  def install
    bin.install "dnscrypt-proxy"
  end

  test do
    system "#{bin}/dnscrypt-proxy"
  end
end
