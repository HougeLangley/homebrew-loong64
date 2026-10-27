class Tbls < Formula
  desc "CI-Friendly tool to document a database"
  homepage "https://example.org/tbls"
  version "1.96.1"
  url "http://127.0.0.1:8080/brew/bottles/tbls--1.96.1.loongarch64.bottle.tar.gz"
  sha256 "828459de1f5548ee6744476d428086bc8a432774784ba682ea135437ed1631db"

  def install
    bin.install "tbls"
  end

  test do
    system "#{bin}/tbls"
  end
end
