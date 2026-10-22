class Ripgrep < Formula
  desc "Line-oriented search tool (ripgrep)"
  homepage "https://example.org/ripgrep"
  version "15.2.0"
  url "http://127.0.0.1:8080/brew/bottles/ripgrep--15.2.0.loongarch64.bottle.tar.gz"
  sha256 "fe35248dd191412dbe1e9581f2e7fc6ad13c77b7cd75add198e1caf97f05e038"

  def install
    bin.install "ripgrep"
  end

  test do
    system "#{bin}/ripgrep"
  end
end
