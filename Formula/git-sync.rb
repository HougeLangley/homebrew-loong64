class Git-sync < Formula
  desc "🔄 A simple tool to backup and sync your git repositories"
  homepage "https://example.org/git-sync"
  version "0.21.0"
  url "http://127.0.0.1:8080/brew/bottles/git-sync--0.21.0.loongarch64.bottle.tar.gz"
  sha256 "c517ff843714b6221501921b247bbc852a29366fd30f1470016c70ada8a93b2e"

  def install
    bin.install "git-sync"
  end

  test do
    system "#{bin}/git-sync"
  end
end
