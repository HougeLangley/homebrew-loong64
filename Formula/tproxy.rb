class Tproxy < Formula
  desc "CLI tool to proxy and analyze TCP connections"
  homepage "https://example.org/tproxy"
  version "0.9.2"
  url "http://127.0.0.1:8080/brew/bottles/tproxy--0.9.2.loongarch64.bottle.tar.gz"
  sha256 "07be6bea5897f4db63aaf96c1df2c57c7b947efce87e781c13a7743f82116c6c"

  def install
    bin.install "tproxy"
  end

  test do
    system "#{bin}/tproxy"
  end
end
