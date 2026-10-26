class Doggo < Formula
  desc "Command-line DNS client"
  homepage "https://example.org/doggo"
  version "1.4.2"
  url "http://127.0.0.1:8080/brew/bottles/doggo--1.4.2.loongarch64.bottle.tar.gz"
  sha256 "c0aec63f471c260e9bd2e59618719e849fd92022b7b5cf2e40453aa061e4e13a"

  def install
    bin.install "doggo"
  end

  test do
    system "#{bin}/doggo"
  end
end
