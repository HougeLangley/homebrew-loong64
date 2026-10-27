class Gor < Formula
  desc "Real-time HTTP traffic replay tool written in Go"
  homepage "https://example.org/gor"
  version "1.3.3"
  url "http://127.0.0.1:8080/brew/bottles/gor--1.3.3.loongarch64.bottle.tar.gz"
  sha256 "ed52c9021b27c602dac1e57f701dfb0bd1552a582f12fc9b35454af52083614d"

  def install
    bin.install "gor"
  end

  test do
    system "#{bin}/gor"
  end
end
