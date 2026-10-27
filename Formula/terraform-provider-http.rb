class Terraform-provider-http < Formula
  desc "Utility provider for interacting with generic HTTP servers as part of a Terraform configur"
  homepage "https://example.org/terraform-provider-http"
  version "3.6.3"
  url "http://127.0.0.1:8080/brew/bottles/terraform-provider-http--3.6.3.loongarch64.bottle.tar.gz"
  sha256 "b1a6bcad4ea3c253cb6e46aa871831620d2c20e8aa91be7865bd06efd160f549"

  def install
    bin.install "terraform-provider-http"
  end

  test do
    system "#{bin}/terraform-provider-http"
  end
end
