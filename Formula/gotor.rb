class Gotor < Formula
  desc "Concurrent Go web crawler with first-class Tor SOCKS5 support, a CLI, versioned JSON repor"
  homepage "https://example.org/gotor"
  version "3.0.0"
  url "http://127.0.0.1:8080/brew/bottles/gotor--3.0.0.loongarch64.bottle.tar.gz"
  sha256 "1bff6e264a6fecacbb38c1cd45d38872182160f6e2c02a1c76f2c33518899c72"

  def install
    bin.install "gotor"
  end

  test do
    system "#{bin}/gotor"
  end
end
