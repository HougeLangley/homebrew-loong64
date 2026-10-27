class Spoofdpi < Formula
  desc "Simple and fast anti-censorship tool written in Go"
  homepage "https://example.org/spoofdpi"
  version "1.5.5"
  url "http://127.0.0.1:8080/brew/bottles/spoofdpi--1.5.5.loongarch64.bottle.tar.gz"
  sha256 "cc389d61ab13f46fefd662b9cb9d824222505ae017ab94f2faa099026b65db57"

  def install
    bin.install "spoofdpi"
  end

  test do
    system "#{bin}/spoofdpi"
  end
end
