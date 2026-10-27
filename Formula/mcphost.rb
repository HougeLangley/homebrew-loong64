class Mcphost < Formula
  desc "CLI host for LLMs to interact with tools via MCP"
  homepage "https://example.org/mcphost"
  version "0.34.0"
  url "http://127.0.0.1:8080/brew/bottles/mcphost--0.34.0.loongarch64.bottle.tar.gz"
  sha256 "ca2168345755e01c3bb362da6489609d6b151dba5b8314f5ff129423e6dda9bc"

  def install
    bin.install "mcphost"
  end

  test do
    system "#{bin}/mcphost"
  end
end
