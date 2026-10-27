class Openapi < Formula
  desc "CLI tools for working with OpenAPI, Arazzo and Overlay specifications"
  homepage "https://example.org/openapi"
  version "1.26.0"
  url "http://127.0.0.1:8080/brew/bottles/openapi--1.26.0.loongarch64.bottle.tar.gz"
  sha256 "708da0fc985e29234a9d89b9def17cfb314c8847ab44491021d06a67c4b34618"

  def install
    bin.install "openapi"
  end

  test do
    system "#{bin}/openapi"
  end
end
