class Govulncheck < Formula
  desc "Database client and tools for the Go vulnerability database"
  homepage "https://example.org/govulncheck"
  version "1.1.4"
  url "http://127.0.0.1:8080/brew/bottles/govulncheck--1.1.4.loongarch64.bottle.tar.gz"
  sha256 "61b9d5e2b3659359a2bf09c01baace534c152aa43060e1ac232d9c2ebb3bc2f6"

  def install
    bin.install "govulncheck"
  end

  test do
    system "#{bin}/govulncheck"
  end
end
