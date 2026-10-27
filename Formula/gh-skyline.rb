class Gh-skyline < Formula
  desc "A GitHub CLI extension to generate a 3D model of your GitHub contribution history"
  homepage "https://example.org/gh-skyline"
  version "0.1.9"
  url "http://127.0.0.1:8080/brew/bottles/gh-skyline--0.1.9.loongarch64.bottle.tar.gz"
  sha256 "562e8bd7d3941ce7dec1bb97b8fd63191b819018c34921bcaab29960b3ed8da5"

  def install
    bin.install "gh-skyline"
  end

  test do
    system "#{bin}/gh-skyline"
  end
end
