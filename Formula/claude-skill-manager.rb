class Claude-skill-manager < Formula
  desc "CLI tool to discover, install, and manage Claude Code skills from a curated community regi"
  homepage "https://example.org/claude-skill-manager"
  version "0.3.1"
  url "http://127.0.0.1:8080/brew/bottles/claude-skill-manager--0.3.1.loongarch64.bottle.tar.gz"
  sha256 "70b0abe659359b6fcbc802b8ac95cf9d6869ee2699d3c3be461660c1031e3b02"

  def install
    bin.install "claude-skill-manager"
  end

  test do
    system "#{bin}/claude-skill-manager"
  end
end
