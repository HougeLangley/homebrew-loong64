class Caddy < Formula
  desc "Fast and extensible multi-platform HTTP/1-2-3 web server with automatic HTTPS"
  homepage "https://example.org/caddy"
  version "2.11.7"
  url "http://127.0.0.1:8080/brew/bottles/caddy--2.11.7.loongarch64.bottle.tar.gz"
  sha256 "0f929c15127c2fced136aa9acdb510b0164a46dea25ded6a9bc0e854d0e6d3e5"

  def install
    bin.install "caddy"
  end

  test do
    system "#{bin}/caddy"
  end
end
