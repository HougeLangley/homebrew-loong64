class Krakend-ce < Formula
  desc "KrakenD Community Edition: High-performance, stateless, declarative, API Gateway written i"
  homepage "https://example.org/krakend-ce"
  version "3.0.2"
  url "http://127.0.0.1:8080/brew/bottles/krakend-ce--3.0.2.loongarch64.bottle.tar.gz"
  sha256 "57bd07efd6d04dcb9452b33c750b8276f9e6765e58776f5aef68e56fc92d46d7"

  def install
    bin.install "krakend-ce"
  end

  test do
    system "#{bin}/krakend-ce"
  end
end
