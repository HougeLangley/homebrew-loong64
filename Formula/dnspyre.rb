class Dnspyre < Formula
  desc "CLI tool for a high QPS DNS benchmark"
  homepage "https://example.org/dnspyre"
  version "3.12.0"
  url "http://127.0.0.1:8080/brew/bottles/dnspyre--3.12.0.loongarch64.bottle.tar.gz"
  sha256 "93e13c580245462d845fb17957b2339ce6781c2de6a0629f0ede8997d1945d65"

  def install
    bin.install "dnspyre"
  end

  test do
    system "#{bin}/dnspyre"
  end
end
