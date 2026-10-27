class Saml2aws < Formula
  desc "Login and retrieve AWS temporary credentials using a SAML IDP"
  homepage "https://example.org/saml2aws"
  version "2.36.19"
  url "http://127.0.0.1:8080/brew/bottles/saml2aws--2.36.19.loongarch64.bottle.tar.gz"
  sha256 "2acc2b07f48ec1e7b004c1afc8bd4dc90cc0c0b96b065451ce1db05eaace8b73"

  def install
    bin.install "saml2aws"
  end

  test do
    system "#{bin}/saml2aws"
  end
end
