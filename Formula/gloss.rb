class Gloss < Formula
  desc "📝 A local-first command glossary for your terminal."
  homepage "https://example.org/gloss"
  version "0.1.1"
  url "http://127.0.0.1:8080/brew/bottles/gloss--0.1.1.loongarch64.bottle.tar.gz"
  sha256 "ae1c491a6ea98a45e6b7791200b54bb1d3223b559de26c879fb41b2778323afe"

  def install
    bin.install "gloss"
  end

  test do
    system "#{bin}/gloss"
  end
end
