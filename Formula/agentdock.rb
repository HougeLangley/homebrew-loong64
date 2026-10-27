class Agentdock < Formula
  desc "Secure MCP runtime for AI agents to operate local machines, servers, and containers with m"
  homepage "https://example.org/agentdock"
  version "1.1.1"
  url "http://127.0.0.1:8080/brew/bottles/agentdock--1.1.1.loongarch64.bottle.tar.gz"
  sha256 "402eaa20c2e6c9e9fea45b6641c59eaabed251af9104d3ed20fd6d10ae2ed416"

  def install
    bin.install "agentdock"
  end

  test do
    system "#{bin}/agentdock"
  end
end
