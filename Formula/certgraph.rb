class Certgraph < Formula
  desc "Crawl the graph of certificate Alternate Names"
  homepage "https://example.org/certgraph"
  version "0.1.3"
  url "http://127.0.0.1:8080/brew/bottles/certgraph--0.1.3.loongarch64.bottle.tar.gz"
  sha256 "3ce16dc04029835b4a46fac04cd54d2dc493e68fc9cfa01dfca83f4888ea780c"

  def install
    bin.install "certgraph"
  end

  test do
    system "#{bin}/certgraph"
  end
end
