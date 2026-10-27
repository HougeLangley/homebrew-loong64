class Gebug < Formula
  desc "Debug Dockerized Go applications better"
  homepage "https://example.org/gebug"
  version "1.0.7"
  url "http://127.0.0.1:8080/brew/bottles/gebug--1.0.7.loongarch64.bottle.tar.gz"
  sha256 "df141e496ea5e2ec835c5a52c356f8dc1c06da07d5092159e8924282ed8b10b6"

  def install
    bin.install "gebug"
  end

  test do
    system "#{bin}/gebug"
  end
end
