class Terraform-mcp-server < Formula
  desc "MCP server for Terraform"
  homepage "https://example.org/terraform-mcp-server"
  version "1.4.1"
  url "http://127.0.0.1:8080/brew/bottles/terraform-mcp-server--1.4.1.loongarch64.bottle.tar.gz"
  sha256 "4c6f70670267da9144d84a48b7b4b7af4236f000d50cf5839bfec27776772f46"

  def install
    bin.install "terraform-mcp-server"
  end

  test do
    system "#{bin}/terraform-mcp-server"
  end
end
