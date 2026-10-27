class Dep-tree < Formula
  desc "Tool for helping developers keep their code bases clean and decoupled. It allows visualisi"
  homepage "https://example.org/dep-tree"
  version "0.23.4"
  url "http://127.0.0.1:8080/brew/bottles/dep-tree--0.23.4.loongarch64.bottle.tar.gz"
  sha256 "f326fb8d103900080bc8aba668af679ad53e5872cfd553a41581ec966fa957a3"

  def install
    bin.install "dep-tree"
  end

  test do
    system "#{bin}/dep-tree"
  end
end
