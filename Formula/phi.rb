class Phi < Formula
  desc "A fast coding agent, rpc plugin, sub-agents, sloppy edits, and mcp"
  homepage "https://example.org/phi"
  version "0.29.2"
  url "http://127.0.0.1:8080/brew/bottles/phi--0.29.2.loongarch64.bottle.tar.gz"
  sha256 "4d6e09288de5a8b50b472b019d625437c98b1e91c377681527343d247c590aec"

  def install
    bin.install "phi"
  end

  test do
    system "#{bin}/phi"
  end
end
