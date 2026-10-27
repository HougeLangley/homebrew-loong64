class Ghalint < Formula
  desc "GitHub Actions linter"
  homepage "https://example.org/ghalint"
  version "1.5.7"
  url "http://127.0.0.1:8080/brew/bottles/ghalint--1.5.7.loongarch64.bottle.tar.gz"
  sha256 "9cc7a48feab8d257e1c55d3eb19394abe7eebb6872d65eb8b8b1adaaad3ee4a7"

  def install
    bin.install "ghalint"
  end

  test do
    system "#{bin}/ghalint"
  end
end
