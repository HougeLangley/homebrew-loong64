class Figurine < Formula
  desc "Print your name in style"
  homepage "https://example.org/figurine"
  version "2.1.1"
  url "http://127.0.0.1:8080/brew/bottles/figurine--2.1.1.loongarch64.bottle.tar.gz"
  sha256 "5ed1321335735119e7eea29531855f9a1a00eacb48f1804e6bbbe1bffc551130"

  def install
    bin.install "figurine"
  end

  test do
    system "#{bin}/figurine"
  end
end
