class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages or do a code review brief for"
  homepage "https://example.org/codegpt"
  version "1.8.0"
  url "http://127.0.0.1:8080/brew/bottles/codegpt--1.8.0.loongarch64.bottle.tar.gz"
  sha256 "b12552af33da2d9fe352365101f77a45efff13acea4233038541a0bbfab2ffcf"

  def install
    bin.install "codegpt"
  end

  test do
    system "#{bin}/codegpt"
  end
end
