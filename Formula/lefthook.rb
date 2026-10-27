class Lefthook < Formula
  desc "Fast and powerful Git hooks manager for any type of projects."
  homepage "https://example.org/lefthook"
  version "2.2.2"
  url "http://127.0.0.1:8080/brew/bottles/lefthook--2.2.2.loongarch64.bottle.tar.gz"
  sha256 "ecd13b853fa5c83f7509efebc756147c0a8a48c4317b3645475d7eb79d6444d2"

  def install
    bin.install "lefthook"
  end

  test do
    system "#{bin}/lefthook"
  end
end
