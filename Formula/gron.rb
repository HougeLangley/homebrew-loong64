class Gron < Formula
  desc "Make JSON greppable"
  homepage "https://example.org/gron"
  version "0.7.1"
  url "http://127.0.0.1:8080/brew/bottles/gron--0.7.1.loongarch64.bottle.tar.gz"
  sha256 "41ae33cb35aa2b7cd684c1df6c2d2a2a5e7fd9a16dd7c5c4215a870313ebb97a"

  def install
    bin.install "gron"
  end

  test do
    system "#{bin}/gron"
  end
end
