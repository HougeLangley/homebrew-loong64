class Tree < Formula
  desc "Display a tree-like view of directories"
  homepage "https://example.org/tree"
  version "2.3.2"
  url "http://127.0.0.1:8080/brew/bottles/tree--2.3.2.loongarch64.bottle.tar.gz"
  sha256 "00e78475fdf58f6cd8dd341990e3c962812dd6a42814dc3faba100465c8d3d8a"

  def install
    bin.install "tree"
  end

  test do
    system "#{bin}/tree"
  end
end
