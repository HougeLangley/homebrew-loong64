class Hargo < Formula
  desc "Hargo is a Go library and command line utility that parses HAR files, can convert to curl "
  homepage "https://example.org/hargo"
  version "2.0.1"
  url "http://127.0.0.1:8080/brew/bottles/hargo--2.0.1.loongarch64.bottle.tar.gz"
  sha256 "a38fe81edbb7af61178d44c8309aff7395151c853618479189f0a4c2266cb43f"

  def install
    bin.install "hargo"
  end

  test do
    system "#{bin}/hargo"
  end
end
