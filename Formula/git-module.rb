class Git-module < Formula
  desc "Package git-module is a Go module for Git access through shell commands"
  homepage "https://example.org/git-module"
  version "1.8.9"
  url "http://127.0.0.1:8080/brew/bottles/git-module--1.8.9.loongarch64.bottle.tar.gz"
  sha256 "45ae601015b497b23726526764ff5bf9a63dde9c68293dcbbafecea641f9096f"

  def install
    bin.install "git-module"
  end

  test do
    system "#{bin}/git-module"
  end
end
