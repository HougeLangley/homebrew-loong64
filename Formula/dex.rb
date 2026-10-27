class Dex < Formula
  desc "OpenID Connect (OIDC) identity and OAuth 2.0 provider with pluggable connectors"
  homepage "https://example.org/dex"
  version "2.46.1"
  url "http://127.0.0.1:8080/brew/bottles/dex--2.46.1.loongarch64.bottle.tar.gz"
  sha256 "920626cb268c74a532378150362e017db850c79ee411119fbc7996e2d7310701"

  def install
    bin.install "dex"
  end

  test do
    system "#{bin}/dex"
  end
end
