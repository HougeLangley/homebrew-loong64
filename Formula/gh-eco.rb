class Gh-eco < Formula
  desc "🦎 gh cli extension to explore the ecosystem"
  homepage "https://example.org/gh-eco"
  version "0.1.6"
  url "http://127.0.0.1:8080/brew/bottles/gh-eco--0.1.6.loongarch64.bottle.tar.gz"
  sha256 "50c5f6a7ce41752acc26e3a7ba83b999c6d6262d2210365b2bcc76d3b51a6098"

  def install
    bin.install "gh-eco"
  end

  test do
    system "#{bin}/gh-eco"
  end
end
