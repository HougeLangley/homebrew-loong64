class Git-hooks < Formula
  desc "git hooks manager"
  homepage "https://example.org/git-hooks"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/git-hooks--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "c6988179cd4c71cd971aff63c797fcc1b20d23c95f1ad75b45d50bc2fea5a1bc"

  def install
    bin.install "git-hooks"
  end

  test do
    system "#{bin}/git-hooks"
  end
end
