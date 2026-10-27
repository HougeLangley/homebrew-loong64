class Md2pdf < Formula
  desc "CLI utility that generates PDF from Markdown"
  homepage "https://example.org/md2pdf"
  version "2.2.23"
  url "http://127.0.0.1:8080/brew/bottles/md2pdf--2.2.23.loongarch64.bottle.tar.gz"
  sha256 "bfc6f0420af150c49620b3aa0e7b9f4f99d9bf9389e58537cfda8d7db1dce04d"

  def install
    bin.install "md2pdf"
  end

  test do
    system "#{bin}/md2pdf"
  end
end
