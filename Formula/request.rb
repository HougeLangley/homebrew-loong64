class Request < Formula
  desc "A developer-friendly HTTP request library for Gopher."
  homepage "https://example.org/request"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/request--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "8dcb4774f59f22659eb96798a30bfe9709f540df74b3cff0a1ac9bb2f4f00c78"

  def install
    bin.install "request"
  end

  test do
    system "#{bin}/request"
  end
end
