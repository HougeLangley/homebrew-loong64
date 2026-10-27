class Hister < Formula
  desc "Self-hosted search engine for your browsing history"
  homepage "https://example.org/hister"
  version "0.20.0"
  url "http://127.0.0.1:8080/brew/bottles/hister--0.20.0.loongarch64.bottle.tar.gz"
  sha256 "7d6094b171d46d1f96dafa0d71f943fb68b6021f5fe4aaab297e9df6a1792edb"

  def install
    bin.install "hister"
  end

  test do
    system "#{bin}/hister"
  end
end
