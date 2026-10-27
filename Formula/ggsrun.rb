class Ggsrun < Formula
  desc "High-performance Google Drive CLI and Model Context Protocol (MCP) Server for LLM/AI agent"
  homepage "https://example.org/ggsrun"
  version "5.3.21"
  url "http://127.0.0.1:8080/brew/bottles/ggsrun--5.3.21.loongarch64.bottle.tar.gz"
  sha256 "f0610fc83907cbc99f6dd3d6dcc10de8f98e5408bf397439d2bf5f46094b3c38"

  def install
    bin.install "ggsrun"
  end

  test do
    system "#{bin}/ggsrun"
  end
end
