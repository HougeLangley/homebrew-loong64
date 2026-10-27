class Mcpsnoop < Formula
  desc "Wireshark for MCP. A transparent proxy between your AI client and MCP server. Watch every "
  homepage "https://example.org/mcpsnoop"
  version "0.28.0"
  url "http://127.0.0.1:8080/brew/bottles/mcpsnoop--0.28.0.loongarch64.bottle.tar.gz"
  sha256 "8958ecb013a58b4147abd3962c27130f3cf442d52f980fdf551214241da6d5e0"

  def install
    bin.install "mcpsnoop"
  end

  test do
    system "#{bin}/mcpsnoop"
  end
end
