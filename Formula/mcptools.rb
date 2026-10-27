class Mcptools < Formula
  desc "CLI for interacting with MCP servers using both stdio and HTTP transport"
  homepage "https://example.org/mcptools"
  version "0.7.1"
  url "http://127.0.0.1:8080/brew/bottles/mcptools--0.7.1.loongarch64.bottle.tar.gz"
  sha256 "a0fc26de43ce87295f66ace1cf3cac4cac9363c60d1b11215f831f403f224932"

  def install
    bin.install "mcptools"
  end

  test do
    system "#{bin}/mcptools"
  end
end
