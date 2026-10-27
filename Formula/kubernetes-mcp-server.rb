class Kubernetes-mcp-server < Formula
  desc "MCP server for Kubernetes"
  homepage "https://example.org/kubernetes-mcp-server"
  version "0.0.69"
  url "http://127.0.0.1:8080/brew/bottles/kubernetes-mcp-server--0.0.69.loongarch64.bottle.tar.gz"
  sha256 "5f971c6b963d32d454b9b300b3036568591d047f9c57803d343d2c5e914e3346"

  def install
    bin.install "kubernetes-mcp-server"
  end

  test do
    system "#{bin}/kubernetes-mcp-server"
  end
end
