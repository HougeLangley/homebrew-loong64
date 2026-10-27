class Mcpproxy-go < Formula
  desc "Supercharge AI Agents, Safely"
  homepage "https://example.org/mcpproxy-go"
  version "0.72.0"
  url "http://127.0.0.1:8080/brew/bottles/mcpproxy-go--0.72.0.loongarch64.bottle.tar.gz"
  sha256 "5a5f360477e0088ffd6e9fbef7e996f2f0007b55c92f650360de5d2a8fcd4832"

  def install
    bin.install "mcpproxy-go"
  end

  test do
    system "#{bin}/mcpproxy-go"
  end
end
