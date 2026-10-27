class Gopass-jsonapi < Formula
  desc "Gopass Browser Bindings"
  homepage "https://example.org/gopass-jsonapi"
  version "1.17.4"
  url "http://127.0.0.1:8080/brew/bottles/gopass-jsonapi--1.17.4.loongarch64.bottle.tar.gz"
  sha256 "34a7cfa7e54bc67beeff5499bb8b02f25f5b0ead0f91a708625982cda294a270"

  def install
    bin.install "gopass-jsonapi"
  end

  test do
    system "#{bin}/gopass-jsonapi"
  end
end
