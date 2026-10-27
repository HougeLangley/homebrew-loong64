class Tsnet-serve < Formula
  desc "Expose HTTP applications to a Tailscale Tailnet network"
  homepage "https://example.org/tsnet-serve"
  version "1.3.2"
  url "http://127.0.0.1:8080/brew/bottles/tsnet-serve--1.3.2.loongarch64.bottle.tar.gz"
  sha256 "5812831508af5a5ee757eaddb8d2688f2077d5b24cde9537747e196705f5a331"

  def install
    bin.install "tsnet-serve"
  end

  test do
    system "#{bin}/tsnet-serve"
  end
end
