class Serve < Formula
  desc "🍽️ a static http server anywhere you need one."
  homepage "https://example.org/serve"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/serve--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "ae5f6144b1b6f367b6ee1f9618d6e31995b68bc5590a1f0967202ae1d5972dcd"

  def install
    bin.install "serve"
  end

  test do
    system "#{bin}/serve"
  end
end
