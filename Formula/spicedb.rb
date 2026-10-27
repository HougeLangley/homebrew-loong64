class Spicedb < Formula
  desc "Open Source, Google Zanzibar-inspired database for scalably storing and querying fine-grai"
  homepage "https://example.org/spicedb"
  version "1.57.0"
  url "http://127.0.0.1:8080/brew/bottles/spicedb--1.57.0.loongarch64.bottle.tar.gz"
  sha256 "d926aa4838f95e8fe219810990b580488afe7e8d9ddf9f040873f13b02b276ed"

  def install
    bin.install "spicedb"
  end

  test do
    system "#{bin}/spicedb"
  end
end
