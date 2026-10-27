class Hydra < Formula
  desc "Internet-scale OpenID Certified™ OpenID Connect and OAuth2.1 provider that integrates with"
  homepage "https://example.org/hydra"
  version "26.2.0"
  url "http://127.0.0.1:8080/brew/bottles/hydra--26.2.0.loongarch64.bottle.tar.gz"
  sha256 "38ce9302c94aad88323cb8da033c32352bd1a8889249dffcc13e18ec31c054ee"

  def install
    bin.install "hydra"
  end

  test do
    system "#{bin}/hydra"
  end
end
