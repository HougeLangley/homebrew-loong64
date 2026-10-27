class Skillshare < Formula
  desc "📚 Sync skills, agents, MCP, plugins to all AI CLI tools with one command and simplify team"
  homepage "https://example.org/skillshare"
  version "0.27.0"
  url "http://127.0.0.1:8080/brew/bottles/skillshare--0.27.0.loongarch64.bottle.tar.gz"
  sha256 "7e56a453c203b8ba94bf7526e7010d3730451550c437a720c63d7340d015cb32"

  def install
    bin.install "skillshare"
  end

  test do
    system "#{bin}/skillshare"
  end
end
