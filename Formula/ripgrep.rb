class Ripgrep < Formula
  desc "Line-oriented search tool (ripgrep)"
  homepage "https://example.org/ripgrep"
  version "15.2.0"
  url "http://127.0.0.1:8080/brew/bottles/ripgrep--15.2.0.loongarch64.bottle.tar.gz"
  sha256 "ba4970209ed6afcd99d99a7718fc20a26dbc5a6eca3852f9d89b764eb28494ad"

  def install
    bin.install "rg"
  end

  test do
    system "#{bin}/ripgrep"
  end
end
