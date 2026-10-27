class Q < Formula
  desc "Tiny command-line DNS client with support for UDP, TCP, DoT, DoH, DoQ and ODoH"
  homepage "https://example.org/q"
  version "0.19.12"
  url "http://127.0.0.1:8080/brew/bottles/q--0.19.12.loongarch64.bottle.tar.gz"
  sha256 "a90c33e2284b3738c9e9cad0393670ad98a4e42e822a09ce2f52ed6cf9ee4596"

  def install
    bin.install "q"
  end

  test do
    system "#{bin}/q"
  end
end
