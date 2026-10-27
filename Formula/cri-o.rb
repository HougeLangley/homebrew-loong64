class Cri-o < Formula
  desc "Open Container Initiative-based implementation of Kubernetes Container Runtime Interface"
  homepage "https://example.org/cri-o"
  version "1.37.2"
  url "http://127.0.0.1:8080/brew/bottles/cri-o--1.37.2.loongarch64.bottle.tar.gz"
  sha256 "42a8640ec3f31b49158e47746fbaef35495492a29526c9055120c25c99a6366d"

  def install
    bin.install "cri-o"
  end

  test do
    system "#{bin}/cri-o"
  end
end
