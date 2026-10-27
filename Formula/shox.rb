class Shox < Formula
  desc "🍫 A customisable, universally compatible terminal status bar"
  homepage "https://example.org/shox"
  version "0.0.19"
  url "http://127.0.0.1:8080/brew/bottles/shox--0.0.19.loongarch64.bottle.tar.gz"
  sha256 "c5644c522538d332b92db3f5e6266720f454ddbe38331e3841a90814909ce525"

  def install
    bin.install "shox"
  end

  test do
    system "#{bin}/shox"
  end
end
