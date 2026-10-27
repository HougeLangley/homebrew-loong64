class Ccheck < Formula
  desc "Check X509 certificate expiration from the command-line, with TAP output"
  homepage "https://example.org/ccheck"
  version "1.0.1"
  url "http://127.0.0.1:8080/brew/bottles/ccheck--1.0.1.loongarch64.bottle.tar.gz"
  sha256 "efb822f37e6bfb8a6d3464a3cd1800922f75980da9d5802c97426a932a39403c"

  def install
    bin.install "ccheck"
  end

  test do
    system "#{bin}/ccheck"
  end
end
