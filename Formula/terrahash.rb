class Terrahash < Formula
  desc "Create and store a hash of the Terraform modules used by your configuration"
  homepage "https://example.org/terrahash"
  version "0.1.0"
  url "http://127.0.0.1:8080/brew/bottles/terrahash--0.1.0.loongarch64.bottle.tar.gz"
  sha256 "2f6aaef19a847550a9db7c38a6472355bad8c9defecfcb720d28ae22623e0c21"

  def install
    bin.install "terrahash"
  end

  test do
    system "#{bin}/terrahash"
  end
end
