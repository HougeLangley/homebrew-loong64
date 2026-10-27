class Oh < Formula
  desc "A new Unix shell."
  homepage "https://example.org/oh"
  version "0.8.3"
  url "http://127.0.0.1:8080/brew/bottles/oh--0.8.3.loongarch64.bottle.tar.gz"
  sha256 "b5fa31c7ccdcc6b152b8a98ce19daabe8fc40353decc3135ee508cb125b7bd2e"

  def install
    bin.install "oh"
  end

  test do
    system "#{bin}/oh"
  end
end
