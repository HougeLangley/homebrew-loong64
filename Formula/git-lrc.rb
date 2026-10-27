class Git-lrc < Formula
  desc "Free, Micro AI Code Reviews That Run on Git Commit"
  homepage "https://example.org/git-lrc"
  version "0.6.17"
  url "http://127.0.0.1:8080/brew/bottles/git-lrc--0.6.17.loongarch64.bottle.tar.gz"
  sha256 "0e743c14a1f57c3cb38c6bdd569b81f949773776377f10ff7b3eb02dafb51c61"

  def install
    bin.install "git-lrc"
  end

  test do
    system "#{bin}/git-lrc"
  end
end
