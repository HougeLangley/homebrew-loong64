class Shox < Formula
  desc "🍫 A customisable, universally compatible terminal status bar"
  homepage "https://example.org/shox"
  version "0.0.19"
  url "http://127.0.0.1:8080/brew/bottles/shox--0.0.19.loongarch64.bottle.tar.gz"
  sha256 "c214c6024601a0624c74e0f8a8eacc68466d962b0c72b226d7bee15c49347026"

  def install
    bin.install "shox"
  end

  test do
    system "#{bin}/shox"
  end
end
