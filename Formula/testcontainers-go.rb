class Testcontainers-go < Formula
  desc "Testcontainers for Go is a Go package that makes it simple to create and clean up containe"
  homepage "https://example.org/testcontainers-go"
  version "0.44.0"
  url "http://127.0.0.1:8080/brew/bottles/testcontainers-go--0.44.0.loongarch64.bottle.tar.gz"
  sha256 "1732b127e4e1f4c4433c2b66db06cb2d2b64c6aa10f59dd6b3bbbd1e95d92666"

  def install
    bin.install "testcontainers-go"
  end

  test do
    system "#{bin}/testcontainers-go"
  end
end
