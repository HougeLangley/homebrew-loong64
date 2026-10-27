class Protoc-gen-go-grpc < Formula
  desc "Protoc plugin that generates code for gRPC-Go clients"
  homepage "https://example.org/protoc-gen-go-grpc"
  version "1.84.0"
  url "http://127.0.0.1:8080/brew/bottles/protoc-gen-go-grpc--1.84.0.loongarch64.bottle.tar.gz"
  sha256 "649f4e0d50d1ca86c7729dbc00da6041d452f8f8f74d9f39529d887bfdf85651"

  def install
    bin.install "protoc-gen-go-grpc"
  end

  test do
    system "#{bin}/protoc-gen-go-grpc"
  end
end
