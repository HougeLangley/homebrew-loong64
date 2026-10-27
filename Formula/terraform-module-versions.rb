class Terraform-module-versions < Formula
  desc "CLI tool that checks Terraform code for module updates. Single binary, no dependencies. li"
  homepage "https://example.org/terraform-module-versions"
  version "3.3.13"
  url "http://127.0.0.1:8080/brew/bottles/terraform-module-versions--3.3.13.loongarch64.bottle.tar.gz"
  sha256 "60da2c67c39ee8e5ac237ac56fcae7d33be20954bc1d2ce438a7764d3f5ecff5"

  def install
    bin.install "terraform-module-versions"
  end

  test do
    system "#{bin}/terraform-module-versions"
  end
end
