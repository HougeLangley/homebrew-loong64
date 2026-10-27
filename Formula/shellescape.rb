class Shellescape < Formula
  desc "Escape arbitrary strings for use as command line arguments"
  homepage "https://example.org/shellescape"
  version "1.6.1"
  url "http://127.0.0.1:8080/brew/bottles/shellescape--1.6.1.loongarch64.bottle.tar.gz"
  sha256 "6c971de873576a4b9fce45d75541086747e684c4acef3765a138ee7f6966a4c1"

  def install
    bin.install "shellescape"
  end

  test do
    system "#{bin}/shellescape"
  end
end
