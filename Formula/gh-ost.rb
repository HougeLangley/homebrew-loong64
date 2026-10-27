class Gh-ost < Formula
  desc "Triggerless online schema migration solution for MySQL"
  homepage "https://example.org/gh-ost"
  version "1.1.11"
  url "http://127.0.0.1:8080/brew/bottles/gh-ost--1.1.11.loongarch64.bottle.tar.gz"
  sha256 "6936e0b4878139df502da784fd19dd704b574bfc3b1a89404813b014fdaaaa6e"

  def install
    bin.install "gh-ost"
  end

  test do
    system "#{bin}/gh-ost"
  end
end
