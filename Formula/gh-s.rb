class Gh-s < Formula
  desc "🔎 search github repositories interactively"
  homepage "https://example.org/gh-s"
  version "0.0.12"
  url "http://127.0.0.1:8080/brew/bottles/gh-s--0.0.12.loongarch64.bottle.tar.gz"
  sha256 "2149172a56772e5cd12c7e5978b5cbc69e9532089bfb4c8ffed22aaa6cb976c9"

  def install
    bin.install "gh-s"
  end

  test do
    system "#{bin}/gh-s"
  end
end
