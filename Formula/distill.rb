class Distill < Formula
  desc "Context intelligence layer for LLM agents: persistent memory with write-time dedup, sensit"
  homepage "https://example.org/distill"
  version "0.9.1"
  url "http://127.0.0.1:8080/brew/bottles/distill--0.9.1.loongarch64.bottle.tar.gz"
  sha256 "401e2e09a15c580b3d52dd125b866a85c7a5c1858a7a821c698299d0d9dc5e9c"

  def install
    bin.install "distill"
  end

  test do
    system "#{bin}/distill"
  end
end
