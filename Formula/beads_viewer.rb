class Beads_viewer < Formula
  desc "Graph-aware TUI for the Beads issue tracker: PageRank, critical path, kanban, dependency D"
  homepage "https://example.org/beads_viewer"
  version "0.25.2"
  url "http://127.0.0.1:8080/brew/bottles/beads_viewer--0.25.2.loongarch64.bottle.tar.gz"
  sha256 "a0e69883535d97ac15e94f12d761ad42e384e5d3bded969d3f8015901faf12b5"

  def install
    bin.install "beads_viewer"
  end

  test do
    system "#{bin}/beads_viewer"
  end
end
