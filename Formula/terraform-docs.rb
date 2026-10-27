class Terraform-docs < Formula
  desc "Tool to generate documentation from Terraform modules"
  homepage "https://example.org/terraform-docs"
  version "0.24.0"
  url "http://127.0.0.1:8080/brew/bottles/terraform-docs--0.24.0.loongarch64.bottle.tar.gz"
  sha256 "be029c446254abd4894b6573b155aef1c4caa9a398a5874026368218a3026cc3"

  def install
    bin.install "terraform-docs"
  end

  test do
    system "#{bin}/terraform-docs"
  end
end
