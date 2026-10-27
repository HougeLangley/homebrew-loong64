class Terraform-lsp < Formula
  desc "Language Server Protocol for Terraform"
  homepage "https://example.org/terraform-lsp"
  version "0.0.12"
  url "http://127.0.0.1:8080/brew/bottles/terraform-lsp--0.0.12.loongarch64.bottle.tar.gz"
  sha256 "87b500d54b79d416d90778e0495fa71731c83a7a5100703a75feed35e050e0a0"

  def install
    bin.install "terraform-lsp"
  end

  test do
    system "#{bin}/terraform-lsp"
  end
end
