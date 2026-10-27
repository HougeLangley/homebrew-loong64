class Jwt < Formula
  desc "Go implementation of JSON Web Tokens (JWT)."
  homepage "https://example.org/jwt"
  version "5.3.1"
  url "http://127.0.0.1:8080/brew/bottles/jwt--5.3.1.loongarch64.bottle.tar.gz"
  sha256 "39719b4324d592d9bb49c13955d9c3012bdd44181026fc0edcb21c8ad38f26ee"

  def install
    bin.install "jwt"
  end

  test do
    system "#{bin}/jwt"
  end
end
