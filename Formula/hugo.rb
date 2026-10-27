class Hugo < Formula
  desc "Configurable static site generator"
  homepage "https://example.org/hugo"
  version "0.168.0"
  url "http://127.0.0.1:8080/brew/bottles/hugo--0.168.0.loongarch64.bottle.tar.gz"
  sha256 "9178e54d41dbd8b1387989cf9705f6c01525a5e789e15111da5f005c6b3d2cb2"

  def install
    bin.install "hugo"
  end

  test do
    system "#{bin}/hugo"
  end
end
