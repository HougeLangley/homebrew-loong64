class Bytebase < Formula
  desc "Database governance built for humans and agents — controlling changes and access across ev"
  homepage "https://example.org/bytebase"
  version "3.24.0"
  url "http://127.0.0.1:8080/brew/bottles/bytebase--3.24.0.loongarch64.bottle.tar.gz"
  sha256 "7e25e12b0e9d4f77c811eacada4d881e93b7584fb089cfa9395aecc078c2ed54"

  def install
    bin.install "bytebase"
  end

  test do
    system "#{bin}/bytebase"
  end
end
