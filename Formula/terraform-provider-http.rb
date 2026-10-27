class Terraform-provider-http < Formula
  desc "Utility provider for interacting with generic HTTP servers as part of a Terraform configur"
  homepage "https://example.org/terraform-provider-http"
  version "3.6.3"
  url "http://127.0.0.1:8080/brew/bottles/terraform-provider-http--3.6.3.loongarch64.bottle.tar.gz"
  sha256 "58968d1658b41a32ab50292551b14d88c8269182f65d1d41e82e827973ea5906"

  def install
    bin.install "terraform-provider-http"
  end

  test do
    system "#{bin}/terraform-provider-http"
  end
end
