class Mcp-grafana < Formula
  desc "MCP server for Grafana"
  homepage "https://example.org/mcp-grafana"
  version "2.1.1"
  url "http://127.0.0.1:8080/brew/bottles/mcp-grafana--2.1.1.loongarch64.bottle.tar.gz"
  sha256 "497f477a409494ed597ac697458c24f9e33e327ca7a07cda679e10a8ee8f57c9"

  def install
    bin.install "mcp-grafana"
  end

  test do
    system "#{bin}/mcp-grafana"
  end
end
