class Grpcui < Formula
  desc "Interactive web UI for gRPC, along the lines of postman"
  homepage "https://example.org/grpcui"
  version "1.5.4"
  url "http://127.0.0.1:8080/brew/bottles/grpcui--1.5.4.loongarch64.bottle.tar.gz"
  sha256 "72570aee61ce906f11f0e457f34f4b1add54e385d93625e1025416e9620dbff3"

  def install
    bin.install "grpcui"
  end

  test do
    system "#{bin}/grpcui"
  end
end
