class Aliddns < Formula
  desc "Aliyun(Alibaba Cloud) ddns for golang"
  homepage "https://example.org/aliddns"
  version "0.0.23"
  url "http://127.0.0.1:8080/brew/bottles/aliddns--0.0.23.loongarch64.bottle.tar.gz"
  sha256 "0147f60890b5cddfc7e9dd804955e534385320fe2eec3ec7b53455930d08a291"

  def install
    bin.install "aliddns"
  end

  test do
    system "#{bin}/aliddns"
  end
end
