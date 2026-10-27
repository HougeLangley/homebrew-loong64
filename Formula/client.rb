class Client < Formula
  desc "Tetiva — desktop API client for HTTP, gRPC, GraphQL and WebSocket (Wails v3 + Vue 3)"
  homepage "https://example.org/client"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/client--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "8ff2355357cd5d40bc9e93898e894cd6efef4f2b266c800958c75402e123afb3"

  def install
    bin.install "client"
  end

  test do
    system "#{bin}/client"
  end
end
