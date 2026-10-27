class Powerline-go < Formula
  desc " A beautiful and useful low-latency prompt for your shell, written in go"
  homepage "https://example.org/powerline-go"
  version "1.26"
  url "http://127.0.0.1:8080/brew/bottles/powerline-go--1.26.loongarch64.bottle.tar.gz"
  sha256 "72c3b69b141d655e0177b8665e3c6d843ff193f0665755e9ae69151ba4d82dc3"

  def install
    bin.install "powerline-go"
  end

  test do
    system "#{bin}/powerline-go"
  end
end
