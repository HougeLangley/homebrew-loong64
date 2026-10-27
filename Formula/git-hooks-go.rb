class Git-hooks-go < Formula
  desc "Git hooks manager"
  homepage "https://example.org/git-hooks-go"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/git-hooks-go--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "1998d11764e02522c6d72c692c4ac23343440fa3c827b61144cc789549b29c85"

  def install
    bin.install "git-hooks-go"
  end

  test do
    system "#{bin}/git-hooks-go"
  end
end
