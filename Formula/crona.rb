class Crona < Formula
  desc "Local-first work tracking for people who live in the terminal."
  homepage "https://example.org/crona"
  version "1.9.0"
  url "http://127.0.0.1:8080/brew/bottles/crona--1.9.0.loongarch64.bottle.tar.gz"
  sha256 "ccd058bc41b66ee0cb5a16eaeed26245a6463b7d387c67fdf54933285804e0c6"

  def install
    bin.install "crona"
  end

  test do
    system "#{bin}/crona"
  end
end
