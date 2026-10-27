class Cassowary < Formula
  desc ":rocket: Modern cross-platform HTTP load-testing tool written in Go"
  homepage "https://example.org/cassowary"
  version "0.19.0"
  url "http://127.0.0.1:8080/brew/bottles/cassowary--0.19.0.loongarch64.bottle.tar.gz"
  sha256 "7443fb60f4c13aad23e24f48fe0f07b825bd984b2a3d6a121fe6848cfb15415a"

  def install
    bin.install "cassowary"
  end

  test do
    system "#{bin}/cassowary"
  end
end
