class Circumflex < Formula
  desc "🌿 It's Hacker News in your terminal"
  homepage "https://example.org/circumflex"
  version "5.1"
  url "http://127.0.0.1:8080/brew/bottles/circumflex--5.1.loongarch64.bottle.tar.gz"
  sha256 "0b8f835b57f75babe5ee065dfe579192a4af68d076442b6bba3c7b4d17105ed1"

  def install
    bin.install "circumflex"
  end

  test do
    system "#{bin}/circumflex"
  end
end
