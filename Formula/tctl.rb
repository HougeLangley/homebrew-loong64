class Tctl < Formula
  desc "Temporal CLI (tctl)"
  homepage "https://example.org/tctl"
  version "1.18.4"
  url "http://127.0.0.1:8080/brew/bottles/tctl--1.18.4.loongarch64.bottle.tar.gz"
  sha256 "e0d8e348c97ae39ee39ef8f1626bc58b80bce0d9ab8a2c40eb9c4f8ea32728f9"

  def install
    bin.install "tctl"
  end

  test do
    system "#{bin}/tctl"
  end
end
