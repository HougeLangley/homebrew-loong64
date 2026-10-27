class Gojq < Formula
  desc "Pure Go implementation of jq"
  homepage "https://example.org/gojq"
  version "0.12.19"
  url "http://127.0.0.1:8080/brew/bottles/gojq--0.12.19.loongarch64.bottle.tar.gz"
  sha256 "4de391af641c446106e320c12a4032305765b39ef3ba01a48f818a62aaaf87fd"

  def install
    bin.install "gojq"
  end

  test do
    system "#{bin}/gojq"
  end
end
