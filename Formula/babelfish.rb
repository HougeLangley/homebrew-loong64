class Babelfish < Formula
  desc "Translate bash scripts to fish"
  homepage "https://example.org/babelfish"
  version "1.2.0"
  url "http://127.0.0.1:8080/brew/bottles/babelfish--1.2.0.loongarch64.bottle.tar.gz"
  sha256 "fce0502f1da0f256fdc3a97b8421ae399117a7f6d8ffc7c8cb251ea08e8e2550"

  def install
    bin.install "babelfish"
  end

  test do
    system "#{bin}/babelfish"
  end
end
