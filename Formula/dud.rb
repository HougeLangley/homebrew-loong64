class Dud < Formula
  desc "CLI tool for versioning data"
  homepage "https://example.org/dud"
  version "0.4.5"
  url "http://127.0.0.1:8080/brew/bottles/dud--0.4.5.loongarch64.bottle.tar.gz"
  sha256 "666f383a9785fbb1ed67cdc638d84c95536fae2d0e1f5cbe5847e5141b157507"

  def install
    bin.install "dud"
  end

  test do
    system "#{bin}/dud"
  end
end
