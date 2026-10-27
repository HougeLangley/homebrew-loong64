class Csrf < Formula
  desc "Package gorilla/csrf provides Cross Site Request Forgery (CSRF) prevention middleware for "
  homepage "https://example.org/csrf"
  version "1.7.3"
  url "http://127.0.0.1:8080/brew/bottles/csrf--1.7.3.loongarch64.bottle.tar.gz"
  sha256 "41f2a11d1d359c56357c42817d0988aa7c6c5f5275913ff26deca3ae323ad60d"

  def install
    bin.install "csrf"
  end

  test do
    system "#{bin}/csrf"
  end
end
