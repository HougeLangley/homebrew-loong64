class Baloo < Formula
  desc "Expressive end-to-end HTTP API testing made easy in Go"
  homepage "https://example.org/baloo"
  version "3.1.0"
  url "http://127.0.0.1:8080/brew/bottles/baloo--3.1.0.loongarch64.bottle.tar.gz"
  sha256 "e4a148f9154259ce9ee708e3addc812be993336c8ce367b3e142671e8c7221dc"

  def install
    bin.install "baloo"
  end

  test do
    system "#{bin}/baloo"
  end
end
