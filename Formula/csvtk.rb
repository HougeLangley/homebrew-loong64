class Csvtk < Formula
  desc "A cross-platform, efficient and practical CSV/TSV toolkit in Golang"
  homepage "https://example.org/csvtk"
  version "0.38.0"
  url "http://127.0.0.1:8080/brew/bottles/csvtk--0.38.0.loongarch64.bottle.tar.gz"
  sha256 "72eec2e0674562b7392ef0e079dc1a829c210690b5085428f76af4da63b11940"

  def install
    bin.install "csvtk"
  end

  test do
    system "#{bin}/csvtk"
  end
end
