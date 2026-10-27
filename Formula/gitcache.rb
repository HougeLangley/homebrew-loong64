class Gitcache < Formula
  desc "When clone from github.com, build mirror cache to improve clone speed"
  homepage "https://example.org/gitcache"
  version "0.1"
  url "http://127.0.0.1:8080/brew/bottles/gitcache--0.1.loongarch64.bottle.tar.gz"
  sha256 "10eaa7acf86ff107298de92b6d753d742dbd30131cd1e60f81813d503e027ce2"

  def install
    bin.install "gitcache"
  end

  test do
    system "#{bin}/gitcache"
  end
end
