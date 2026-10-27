class Go-rice < Formula
  desc "Easily embed resources like HTML, JS, CSS, images, and templates in Go"
  homepage "https://example.org/go-rice"
  version "1.0.3"
  url "http://127.0.0.1:8080/brew/bottles/go-rice--1.0.3.loongarch64.bottle.tar.gz"
  sha256 "922b71b5eacc39209ee82866b9acf68d8f3bcf4c4a88ad8989457804396cfaf6"

  def install
    bin.install "go-rice"
  end

  test do
    system "#{bin}/go-rice"
  end
end
