class Scw < Formula
  desc "Command-line Interface for Scaleway"
  homepage "https://example.org/scw"
  version "2.65.2"
  url "http://127.0.0.1:8080/brew/bottles/scw--2.65.2.loongarch64.bottle.tar.gz"
  sha256 "7a81b75871106abeec6c869f0b434590bb3b2bbe1ae30d416c931de8a91eebbb"

  def install
    bin.install "scw"
  end

  test do
    system "#{bin}/scw"
  end
end
