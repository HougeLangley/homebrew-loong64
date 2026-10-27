class Tdx < Formula
  desc "tdx - your todos, in markdown, done fast."
  homepage "https://example.org/tdx"
  version "0.14.0"
  url "http://127.0.0.1:8080/brew/bottles/tdx--0.14.0.loongarch64.bottle.tar.gz"
  sha256 "083d45292d3cc1bfee5412887a1f3505155db15fe42d7328e75e1e88454c559c"

  def install
    bin.install "tdx"
  end

  test do
    system "#{bin}/tdx"
  end
end
