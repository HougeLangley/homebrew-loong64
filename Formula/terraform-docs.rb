class Terraform-docs < Formula
  desc "Tool to generate documentation from Terraform modules"
  homepage "https://example.org/terraform-docs"
  version "0.24.0"
  url "http://127.0.0.1:8080/brew/bottles/terraform-docs--0.24.0.loongarch64.bottle.tar.gz"
  sha256 "d9f2a861a03b407adc91e497902404a80bfd7cae50761d26a2701fb41c065791"

  def install
    bin.install "terraform-docs"
  end

  test do
    system "#{bin}/terraform-docs"
  end
end
