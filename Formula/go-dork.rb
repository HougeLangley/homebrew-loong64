class Go-dork < Formula
  desc "The fastest dork scanner written in Go."
  homepage "https://example.org/go-dork"
  version "1.0.3"
  url "http://127.0.0.1:8080/brew/bottles/go-dork--1.0.3.loongarch64.bottle.tar.gz"
  sha256 "f74274e28bc52c67ab10395cee9524bbcb8f01c42abf6689160c8416e6db696d"

  def install
    bin.install "go-dork"
  end

  test do
    system "#{bin}/go-dork"
  end
end
