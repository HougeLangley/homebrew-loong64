class Kanban-md < Formula
  desc "File-based kanban board for autonomous agentic loop. CLI and TUI for multi-agent workflows"
  homepage "https://example.org/kanban-md"
  version "0.39.0"
  url "http://127.0.0.1:8080/brew/bottles/kanban-md--0.39.0.loongarch64.bottle.tar.gz"
  sha256 "10f723ab6ef53aa41b4b10fc14a0b66d3ed14d9220cf97dbf590a16a2a485d2c"

  def install
    bin.install "kanban-md"
  end

  test do
    system "#{bin}/kanban-md"
  end
end
