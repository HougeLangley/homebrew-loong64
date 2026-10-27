class Gotags < Formula
  desc "Tag generator for Go, compatible with ctags"
  homepage "https://example.org/gotags"
  version "1.4.1"
  url "http://127.0.0.1:8080/brew/bottles/gotags--1.4.1.loongarch64.bottle.tar.gz"
  sha256 "6894e949539ea96a2c3a77e11b759a0d05884f9507326304fa363ca59ee47005"

  def install
    bin.install "gotags"
  end

  test do
    system "#{bin}/gotags"
  end
end
