class Terraform-mcp-server < Formula
  desc "MCP server for Terraform"
  homepage "https://example.org/terraform-mcp-server"
  version "1.4.1"
  url "http://127.0.0.1:8080/brew/bottles/terraform-mcp-server--1.4.1.loongarch64.bottle.tar.gz"
  sha256 "910e3d4a299d207988c1c164967fd87344044470431ea45480b4385b6e065e27"

  def install
    bin.install "terraform-mcp-server"
  end

  test do
    system "#{bin}/terraform-mcp-server"
  end
end
