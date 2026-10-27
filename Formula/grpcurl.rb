class Grpcurl < Formula
  desc "Like cURL, but for gRPC"
  homepage "https://example.org/grpcurl"
  version "1.9.4"
  url "http://127.0.0.1:8080/brew/bottles/grpcurl--1.9.4.loongarch64.bottle.tar.gz"
  sha256 "cfdef2d906a7436aae9ffcdda952a1429ba360706fbcb615659ae877615f9003"

  def install
    bin.install "grpcurl"
  end

  test do
    system "#{bin}/grpcurl"
  end
end
