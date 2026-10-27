class Templ < Formula
  desc "Language for writing HTML user interfaces in Go"
  homepage "https://example.org/templ"
  version "0.3.1100"
  url "http://127.0.0.1:8080/brew/bottles/templ--0.3.1100.loongarch64.bottle.tar.gz"
  sha256 "c0fd154a340424c4fdbdf51125eb643d9b0afaf00d6585cbc0d9219160e2c0b5"

  def install
    bin.install "templ"
  end

  test do
    system "#{bin}/templ"
  end
end
