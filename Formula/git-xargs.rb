class Git-xargs < Formula
  desc "git-xargs is a command-line tool (CLI) for making updates across multiple Github repositor"
  homepage "https://example.org/git-xargs"
  version "0.1.16"
  url "http://127.0.0.1:8080/brew/bottles/git-xargs--0.1.16.loongarch64.bottle.tar.gz"
  sha256 "d37a003619a1f2b1a2e1c34170020c8d3ae4c221f91e75191cc618b06a02d48b"

  def install
    bin.install "git-xargs"
  end

  test do
    system "#{bin}/git-xargs"
  end
end
