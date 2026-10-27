class Gziphandler < Formula
  desc "Go middleware to gzip HTTP responses"
  homepage "https://example.org/gziphandler"
  version "1.1.1"
  url "http://127.0.0.1:8080/brew/bottles/gziphandler--1.1.1.loongarch64.bottle.tar.gz"
  sha256 "d680f7e98d558736b791113a791f1a0349f88b32e010e356027652909e589a1b"

  def install
    bin.install "gziphandler"
  end

  test do
    system "#{bin}/gziphandler"
  end
end
