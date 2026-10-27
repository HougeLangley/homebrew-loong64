class Terrahash < Formula
  desc "Create and store a hash of the Terraform modules used by your configuration"
  homepage "https://example.org/terrahash"
  version "0.1.0"
  url "http://127.0.0.1:8080/brew/bottles/terrahash--0.1.0.loongarch64.bottle.tar.gz"
  sha256 "b6514205bd85d6263555018cb2134681675d5be87b8c23a4a3ad2599b6e0f0a8"

  def install
    bin.install "terrahash"
  end

  test do
    system "#{bin}/terrahash"
  end
end
