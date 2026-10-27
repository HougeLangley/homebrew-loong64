class Goreplay < Formula
  desc "GoReplay is an open-source tool for capturing and replaying live HTTP traffic into a test "
  homepage "https://example.org/goreplay"
  version "1.3.3"
  url "http://127.0.0.1:8080/brew/bottles/goreplay--1.3.3.loongarch64.bottle.tar.gz"
  sha256 "b22d7e327d31f1990ffe9e64ee82684a970cc1b6ec6a5a916da59ef1f8c562d1"

  def install
    bin.install "goreplay"
  end

  test do
    system "#{bin}/goreplay"
  end
end
