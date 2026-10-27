class Nanobot < Formula
  desc "Build MCP Agents"
  homepage "https://example.org/nanobot"
  version "0.0.92"
  url "http://127.0.0.1:8080/brew/bottles/nanobot--0.0.92.loongarch64.bottle.tar.gz"
  sha256 "f4fdad1ef19d881655ca50acee55624503cd156a7959d84e5ad643e0a41de3f0"

  def install
    bin.install "nanobot"
  end

  test do
    system "#{bin}/nanobot"
  end
end
