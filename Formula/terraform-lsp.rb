class Terraform-lsp < Formula
  desc "Language Server Protocol for Terraform"
  homepage "https://example.org/terraform-lsp"
  version "0.0.12"
  url "http://127.0.0.1:8080/brew/bottles/terraform-lsp--0.0.12.loongarch64.bottle.tar.gz"
  sha256 "e8cbb5145ee621fd685699aa456cba5d688cfcd5d7e5b9b0e52293266b75e0b9"

  def install
    bin.install "terraform-lsp"
  end

  test do
    system "#{bin}/terraform-lsp"
  end
end
