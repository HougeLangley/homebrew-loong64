class Sq < Formula
  desc "Data wrangler with jq-like query language"
  homepage "https://example.org/sq"
  version "0.55.0"
  url "http://127.0.0.1:8080/brew/bottles/sq--0.55.0.loongarch64.bottle.tar.gz"
  sha256 "0b2ca181c4b3bc7a8e10f3659bbe6b6cba0c91897c31ad9a78bb4734a8cc6e5f"

  def install
    bin.install "sq"
  end

  test do
    system "#{bin}/sq"
  end
end
