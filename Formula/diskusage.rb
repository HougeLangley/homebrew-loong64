class Diskusage < Formula
  desc "💥A tool for showing disk usage(Linux, MacOS and Windows), it is a very fast utility to fin"
  homepage "https://example.org/diskusage"
  version "1.2.8"
  url "http://127.0.0.1:8080/brew/bottles/diskusage--1.2.8.loongarch64.bottle.tar.gz"
  sha256 "9e5c5f3531d5cb60786ba554984a0a187b726647ea57b6541b97f66bff756ced"

  def install
    bin.install "diskusage"
  end

  test do
    system "#{bin}/diskusage"
  end
end
