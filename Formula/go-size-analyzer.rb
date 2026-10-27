class Go-size-analyzer < Formula
  desc "Analyzing the dependencies in compiled Golang binaries"
  homepage "https://example.org/go-size-analyzer"
  version "1.14.1"
  url "http://127.0.0.1:8080/brew/bottles/go-size-analyzer--1.14.1.loongarch64.bottle.tar.gz"
  sha256 "3975f6eaecd25ea23a60bf81663464c9b6689f4facd2ab4eea378623d16e542c"

  def install
    bin.install "go-size-analyzer"
  end

  test do
    system "#{bin}/go-size-analyzer"
  end
end
