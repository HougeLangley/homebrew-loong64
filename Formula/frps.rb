class Frps < Formula
  desc "Server app of fast reverse proxy to expose a local server to the internet"
  homepage "https://example.org/frps"
  version "0.71.1"
  url "http://127.0.0.1:8080/brew/bottles/frps--0.71.1.loongarch64.bottle.tar.gz"
  sha256 "ef34164c2547c0f8a8d50d429290a65089b72a9abd033d127dd75c8e3ff8924a"

  def install
    bin.install "frps"
  end

  test do
    system "#{bin}/frps"
  end
end
