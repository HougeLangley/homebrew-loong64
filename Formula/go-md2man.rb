class Go-md2man < Formula
  desc "Converts markdown into roff (man pages)"
  homepage "https://example.org/go-md2man"
  version "2.0.7"
  url "http://127.0.0.1:8080/brew/bottles/go-md2man--2.0.7.loongarch64.bottle.tar.gz"
  sha256 "56ec324302d839e71e2b88f2d9ae76daeb24ef7cc7a401e3156fc0fa6ed77842"

  def install
    bin.install "go-md2man"
  end

  test do
    system "#{bin}/go-md2man"
  end
end
