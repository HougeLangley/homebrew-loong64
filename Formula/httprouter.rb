class Httprouter < Formula
  desc "A high performance HTTP request router that scales well"
  homepage "https://example.org/httprouter"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/httprouter--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "4d1e58d052c0cf51abab79dc16b26b8c4cbca77d65e4d42deb3cf88d9014c628"

  def install
    bin.install "httprouter"
  end

  test do
    system "#{bin}/httprouter"
  end
end
