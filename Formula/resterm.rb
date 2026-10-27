class Resterm < Formula
  desc "Terminal API client for HTTP, GraphQL, gRPC, WebSocket and SSE. Plain .http files you can "
  homepage "https://example.org/resterm"
  version "1.16.1"
  url "http://127.0.0.1:8080/brew/bottles/resterm--1.16.1.loongarch64.bottle.tar.gz"
  sha256 "d2397d4e48b44f17a48f180a792889f6b13fc178aa1b4cb6e307f8632d7b32e5"

  def install
    bin.install "resterm"
  end

  test do
    system "#{bin}/resterm"
  end
end
