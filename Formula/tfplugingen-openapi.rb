class Tfplugingen-openapi < Formula
  desc "OpenAPI to Terraform Provider Code Generation Specification"
  homepage "https://example.org/tfplugingen-openapi"
  version "0.3.0"
  url "http://127.0.0.1:8080/brew/bottles/tfplugingen-openapi--0.3.0.loongarch64.bottle.tar.gz"
  sha256 "d4732de196f965aebdce78c9efef6477930df7c5c748268a1134b1d20e927e40"

  def install
    bin.install "tfplugingen-openapi"
  end

  test do
    system "#{bin}/tfplugingen-openapi"
  end
end
