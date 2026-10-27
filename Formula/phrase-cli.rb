class Phrase-cli < Formula
  desc "Tool to interact with the Phrase API"
  homepage "https://example.org/phrase-cli"
  version "2.71.0"
  url "http://127.0.0.1:8080/brew/bottles/phrase-cli--2.71.0.loongarch64.bottle.tar.gz"
  sha256 "176183e8784813ef08da9171f37cdfaae68a64b30b4f61142924ea6579dd77d3"

  def install
    bin.install "phrase-cli"
  end

  test do
    system "#{bin}/phrase-cli"
  end
end
