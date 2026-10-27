class Nexttrace < Formula
  desc "Open source visual route tracking CLI tool"
  homepage "https://example.org/nexttrace"
  version "1.7.5"
  url "http://127.0.0.1:8080/brew/bottles/nexttrace--1.7.5.loongarch64.bottle.tar.gz"
  sha256 "40b992820b10fb2f11670a14cc7454b3acbe388a6d0d2c199422546fb0e02e17"

  def install
    bin.install "nexttrace"
  end

  test do
    system "#{bin}/nexttrace"
  end
end
