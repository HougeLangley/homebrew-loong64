class Bento < Formula
  desc "Fancy stream processing made operationally mundane"
  homepage "https://example.org/bento"
  version "1.22.0"
  url "http://127.0.0.1:8080/brew/bottles/bento--1.22.0.loongarch64.bottle.tar.gz"
  sha256 "54f5260a505489937d2fc556c1324b68bd1dcfae9ee9971415bdfd82fccbf014"

  def install
    bin.install "bento"
  end

  test do
    system "#{bin}/bento"
  end
end
