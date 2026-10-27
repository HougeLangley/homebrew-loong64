class Ory-hydra < Formula
  desc "OpenID Certified OAuth 2.0 Server and OpenID Connect Provider"
  homepage "https://example.org/ory-hydra"
  version "26.2.0"
  url "http://127.0.0.1:8080/brew/bottles/ory-hydra--26.2.0.loongarch64.bottle.tar.gz"
  sha256 "d5f6e88f9a2c6389dc9e780bd5ee932dec200feb0e1ba746f5df26c4d66365b5"

  def install
    bin.install "ory-hydra"
  end

  test do
    system "#{bin}/ory-hydra"
  end
end
