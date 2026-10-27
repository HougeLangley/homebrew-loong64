class Testcontainers-go < Formula
  desc "Testcontainers for Go is a Go package that makes it simple to create and clean up containe"
  homepage "https://example.org/testcontainers-go"
  version "0.44.0"
  url "http://127.0.0.1:8080/brew/bottles/testcontainers-go--0.44.0.loongarch64.bottle.tar.gz"
  sha256 "fddafa0e78c18bcec4b2374d755ef99a354620d96319c708d53280bf8d6f27fd"

  def install
    bin.install "testcontainers-go"
  end

  test do
    system "#{bin}/testcontainers-go"
  end
end
