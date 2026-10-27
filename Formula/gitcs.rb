class Gitcs < Formula
  desc "📈 Command line tool written in Go. It allows developers to scan their local Git repositori"
  homepage "https://example.org/gitcs"
  version "1.2.2"
  url "http://127.0.0.1:8080/brew/bottles/gitcs--1.2.2.loongarch64.bottle.tar.gz"
  sha256 "3f531eae6f58059c0119b7dec52111d300fb4eeea2b483810474675d78e805f2"

  def install
    bin.install "gitcs"
  end

  test do
    system "#{bin}/gitcs"
  end
end
