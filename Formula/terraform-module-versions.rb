class Terraform-module-versions < Formula
  desc "CLI tool that checks Terraform code for module updates. Single binary, no dependencies. li"
  homepage "https://example.org/terraform-module-versions"
  version "3.3.13"
  url "http://127.0.0.1:8080/brew/bottles/terraform-module-versions--3.3.13.loongarch64.bottle.tar.gz"
  sha256 "cf2dea036ff675d5c9d72f01e6ca044a3c4dd35abff47c4cc4bf65e5faa60e2c"

  def install
    bin.install "terraform-module-versions"
  end

  test do
    system "#{bin}/terraform-module-versions"
  end
end
