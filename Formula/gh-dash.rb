class Gh-dash < Formula
  desc "A rich terminal UI for GitHub that doesn't break your flow."
  homepage "https://example.org/gh-dash"
  version "4.26.2"
  url "http://127.0.0.1:8080/brew/bottles/gh-dash--4.26.2.loongarch64.bottle.tar.gz"
  sha256 "9ad8a066e98c55857283f834e7c4bf050c0b07991ea6715e0be8e339ab7a6e5b"

  def install
    bin.install "gh-dash"
  end

  test do
    system "#{bin}/gh-dash"
  end
end
